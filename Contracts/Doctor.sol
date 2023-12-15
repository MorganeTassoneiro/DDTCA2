// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract MedicalAppointment {
    enum AppointmentStatus { Pending, Confirmed, Completed, Canceled }

    struct Appointment {
        address patient;
        uint256 date;
        AppointmentStatus status;
    }

    mapping(uint256 => Appointment) public appointments;
    address public healthcareProvider;

    modifier onlyHealthcareProvider() {
        require(msg.sender == healthcareProvider, "Only the healthcare provider can perform this action");
        _;
    }

    constructor() {
        healthcareProvider = msg.sender;
    }

    function isSlotAvailable(uint256 _date) public view returns (bool) {
        return appointments[_date].status == AppointmentStatus.Pending;
    }

    function bookAppointment(uint256 _date) public {
        require(isSlotAvailable(_date), "This slot is not available for booking!");

        appointments[_date] = Appointment({
            patient: msg.sender,
            date: _date,
            status: AppointmentStatus.Pending
        });
    }

    function confirmAppointment(uint256 _date) public onlyHealthcareProvider {
        require(appointments[_date].status == AppointmentStatus.Pending, "This appointment is not pending confirmation");
        
        appointments[_date].status = AppointmentStatus.Confirmed;
    }

    function completeAppointment(uint256 _date) public onlyHealthcareProvider {
        require(appointments[_date].status == AppointmentStatus.Confirmed, "Cannot complete an appointment that is not confirmed");

        appointments[_date].status = AppointmentStatus.Completed;
    }

    function cancelAppointment(uint256 _date) public onlyHealthcareProvider {
        require(appointments[_date].status != AppointmentStatus.Completed, "Cannot cancel a completed appointment");

        appointments[_date].status = AppointmentStatus.Canceled;
    }
}
