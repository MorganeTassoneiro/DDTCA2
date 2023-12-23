// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

/**
 * @title AppointmentStorage
 * @dev Store & retrieve doctor appointment information
 */
contract AppointmentStorage {

    uint256 public appointmentDate;
    address public patient;

    /**
     * @dev Store doctor appointment information
     * @param date Date of the appointment
     * @param patientAddress Address of the patient
     */
    function storeAppointment(uint256 date, address patientAddress) public {
        appointmentDate = date;
        patient = patientAddress;
    }

    /**
     * @dev Retrieve appointment information
     * @return date Date of the appointment
     * @return patientAddress Address of the patient
     */
    function retrieveAppointment() public view returns (uint256 date, address patientAddress) {
        return (appointmentDate, patient);
    }
}
