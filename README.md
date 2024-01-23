# ResStock/BuildStockBatch Dockerfile

*I had a lot of trouble getting an environment set up, hopefully this helps someone else.*  

ResStock is a granular library of residential building data that has been validated across the U.S. to represent local conditions. ResStock integrates with EnergyPlus to simulate those buildings. BuildStockBatch and OpenStudio-HPXML allow us to execute those simulations in high performance environments.  

The dockerfile installs [**ResStock v3.2.0**](https://github.com/NREL/resstock/releases/tag/v3.2.0) as well as dependencies in an ubuntu environment. The installed software is located as follows:  

```bash
|-usr/
|   |-local/
|       |-OpenStudio-X.X.X/
|-home/
    |-resstock/
        |-buildstockbatch/
        |-OpenStudio-HPXML/
        |-resstock/
```

## Quickstart  

Not to replace any docker tutorial, to build a docker image from this dockerfile use the command: `docker build . -t image_name` from the directory with the dockerfile.  

## Dependencies  

ResStock v3.2.0 uses:

* OpenStudio v3.7.0  
* EnergyPlus v23.2  
* buildstockbatch v2023.10.0  
* OpenStudio-HPXML v1.7.0  

## Links:  

**BuildStockBatch**[Repo](https://github.com/NREL/buildstockbatch/)  
**ResStock**[Repo](https://github.com/NREL/resstock/)  
**OpenStudio-HPXML**[Repo](https://github.com/NREL/OpenStudio-HPXML)  

