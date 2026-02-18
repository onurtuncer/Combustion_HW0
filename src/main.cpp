#include <cantera/base/Solution.h>
#include <iostream>

int main() {
    auto sol = Cantera::newSolution("gri30.yaml");
    auto& gas = sol->thermo();

    gas.setState_TPX(300.0, Cantera::OneAtm, "CH4:1, O2:2, N2:7.52");

    std::cout << "T [K]   = " << gas.temperature() << "\n";
    std::cout << "P [Pa]  = " << gas.pressure() << "\n";
    std::cout << "h [J/kg]= " << gas.enthalpy_mass() << "\n";
    std::cout << "s [J/kg-K]= " << gas.entropy_mass() << "\n";
    std::cout << "cp [J/kg-K]= " << gas.cp_mass() << "\n";
}
