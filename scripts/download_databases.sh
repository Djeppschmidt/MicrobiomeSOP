#!/bin/bash

# Script to download taxonomy reference databases for DADA2

set -e

echo "Taxonomy Database Download Script"
echo "=================================="
echo ""

# Function to download SILVA databases
download_silva() {
    echo "Downloading SILVA v138.1 databases..."
    
    # Training set
    if [ ! -f "silva_nr99_v138.1_train_set.fa.gz" ]; then
        echo "Downloading SILVA training set..."
        wget -q --show-progress https://zenodo.org/record/4587955/files/silva_nr99_v138.1_train_set.fa.gz
        echo "✓ SILVA training set downloaded"
    else
        echo "✓ SILVA training set already exists"
    fi
    
    # Species assignment
    if [ ! -f "silva_species_assignment_v138.1.fa.gz" ]; then
        echo "Downloading SILVA species assignment..."
        wget -q --show-progress https://zenodo.org/record/4587955/files/silva_species_assignment_v138.1.fa.gz
        echo "✓ SILVA species assignment downloaded"
    else
        echo "✓ SILVA species assignment already exists"
    fi
}

# Function to download UNITE database
download_unite() {
    echo "Downloading UNITE database..."
    
    if [ ! -f "sh_general_release_dynamic_s_all_10.05.2021.fasta" ]; then
        echo "Note: UNITE database requires manual download from PlutoF"
        echo "Please visit: https://doi.plutof.ut.ee/doi/10.15156/BIO/2483915"
        echo "Download the file and place it in the project root directory"
        echo ""
        echo "Alternative: Download from direct link"
        wget -q --show-progress https://files.plutof.ut.ee/public/orig/98/AE/98AE96C6593FC9C52D1C46B96C2D9064291F4BCE99C60593BFAD7FA10DF1[...].gz \
            -O sh_general_release_dynamic_s_all_10.05.2021.fasta.gz || {
            echo "Direct download failed. Please download manually from PlutoF."
            return 1
        }
        
        # Uncompress if downloaded
        if [ -f "sh_general_release_dynamic_s_all_10.05.2021.fasta.gz" ]; then
            gunzip sh_general_release_dynamic_s_all_10.05.2021.fasta.gz
            echo "✓ UNITE database downloaded and extracted"
        fi
    else
        echo "✓ UNITE database already exists"
    fi
}

# Main menu
echo "Select databases to download:"
echo "1) SILVA (for bacteria/archaea - 16S rRNA)"
echo "2) UNITE (for fungi - ITS)"
echo "3) Both"
echo ""
read -p "Enter choice [1-3]: " choice

case $choice in
    1)
        download_silva
        ;;
    2)
        download_unite
        ;;
    3)
        download_silva
        echo ""
        download_unite
        ;;
    *)
        echo "Invalid choice"
        exit 1
        ;;
esac

echo ""
echo "=================================="
echo "Download complete!"
echo ""
echo "Update config.yaml with the correct database paths if needed."
