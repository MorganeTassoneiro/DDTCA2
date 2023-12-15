// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "console.sol";

/**
 * @title DoctorAppointment
 * @dev Set & change doctor for appointments
 */
contract DoctorAppointment {

    address private doctor;

    // Event for EVM logging
    event DoctorSet(address indexed oldDoctor, address indexed newDoctor);
    event AppointmentBooked(address indexed patient, uint256 date);

    // Modifier to check if caller is the doctor
    modifier isDoctor() {
        require(msg.sender == doctor, "Caller is not the doctor");
        _;
    }

    /**
     * @dev Set contract deployer as the initial doctor
     */
    constructor() {
        console.log("DoctorAppointment contract deployed by:", msg.sender);
        doctor = msg.sender; // 'msg.sender' is the sender of the current call, contract deployer for a constructor
        emit DoctorSet(address(0), doctor);
    }

    /**
     * @dev Change the doctor
     * @param newDoctor Address of the new doctor
     */
    function changeDoctor(address newDoctor) public isDoctor {
        emit DoctorSet(doctor, newDoctor);
        doctor = newDoctor;
    }

    /**
     * @dev Book a doctor appointment
     * @param date Date of the appointment
     */
    function bookAppointment(uint256 date) public {
        emit AppointmentBooked(msg.sender, date);
    }

    /**
     * @dev Return the address of the current doctor
     * @return Address of the doctor
     */
    function getDoctor() external view returns (address) {
        return doctor;
    }
}
