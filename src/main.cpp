// ------------------------------------------------------------------------------
// Project: ITU UCK427E
// Copyright(c) 2026, Onur Tuncer, PhD, Istanbul Technical University
//
// SPDX - License - Identifier: MIT
// License - Filename: LICENSE
// ------------------------------------------------------------------------------

#include <cantera/base/Solution.h>
#include <cantera/base/global.h> // for addDataDirectory()
#include <cantera/thermo/ThermoPhase.h>
#include <iostream>

int main()
{
    try {
        std::cout << "Starting...\n";

        // Add repo-local data directory
        Cantera::addDataDirectory("data");

        auto sol = Cantera::newSolution("gri30.yaml");

        // thermo() is a shared_ptr<ThermoPhase> in your build
        auto gas = sol->thermo();

        // Use -> for shared_ptr
        gas->setState_TPX(300.0, Cantera::OneAtm, "CH4:1, O2:2, N2:7.52");

        std::cout << "T [K]      = " << gas->temperature() << "\n";
        std::cout << "P [Pa]     = " << gas->pressure() << "\n";
        std::cout << "h [J/kg]   = " << gas->enthalpy_mass() << "\n";
        std::cout << "s [J/kg-K] = " << gas->entropy_mass() << "\n";
        std::cout << "cp [J/kg-K]= " << gas->cp_mass() << "\n";

        // Adiabatic equilibrium at constant H,P
        gas->equilibrate("HP");

        std::cout << "T_ad [K]   = " << gas->temperature() << "\n";

        } catch (const std::exception& e) {
        std::cerr << "Exception:\n" << e.what() << "\n";
    }

    return 0;
}