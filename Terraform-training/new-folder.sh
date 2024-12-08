#!/bin/bash

# Base directory
BASE_DIR="Terraform-training"

# Remove existing directory if exists and create fresh
rm -rf $BASE_DIR
mkdir -p $BASE_DIR

# Define topic details with specific names for diagrams and manifests
declare -A TOPIC_DETAILS=(
    ["01-introduction-to-iac"]="iac-diagrams:iac-manifests"
    ["02-terraform-setup"]="setup-diagrams:setup-manifests"
    ["03-terraform-basics"]="basics-diagrams:basics-manifests"
    ["04-terraform-providers-resources"]="providers-diagrams:providers-manifests"
    ["05-variables-and-outputs"]="variables-diagrams:variables-manifests"
    ["06-terraform-state-management"]="state-diagrams:state-manifests"
    ["07-terraform-modules"]="modules-diagrams:modules-manifests"
    ["08-terraform-cloud-integration"]="cloud-diagrams:cloud-manifests"
    ["09-terraform-workspaces"]="workspace-diagrams:workspace-manifests"
    ["10-testing-terraform"]="testing-diagrams:testing-manifests"
    ["11-cicd-terraform"]="cicd-diagrams:cicd-manifests"
    ["12-automating-terraform"]="automation-diagrams:automation-manifests"
)

# Create directories and files for each topic
for topic in "${!TOPIC_DETAILS[@]}"; do
    # Split the details into diagram and manifest names
    IFS=':' read -r diagram_name manifest_name <<< "${TOPIC_DETAILS[$topic]}"
    
    # Create main topic directory
    mkdir -p "$BASE_DIR/$topic"
    
    # Create markdown files
    echo "# ${topic#*-} - Theory" > "$BASE_DIR/$topic/theory.md"
    echo "# ${topic#*-} - Labs" > "$BASE_DIR/$topic/labs.md"
    echo "# ${topic#*-} - Practice Questions" > "$BASE_DIR/$topic/practice-test.md"
    
    # Create manifest directory
    mkdir -p "$BASE_DIR/$topic/$manifest_name"
    
    # Create diagram directories
    mkdir -p "$BASE_DIR/$topic/$diagram_name/theory"
    mkdir -p "$BASE_DIR/$topic/$diagram_name/labs"
    
    # Create Python files for theory diagrams
    cat > "$BASE_DIR/$topic/$diagram_name/theory/${topic#*-}_concepts.py" <<EOF
from diagrams import Diagram, Cluster
from diagrams.programming.framework import Terraform
from diagrams.aws.compute import EC2
from diagrams.aws.network import VPC

# Theory concept diagrams for ${topic#*-}
def create_concept_diagram():
    with Diagram("${topic#*-} Concepts", show=False):
        # Add diagram components here
        pass

if __name__ == "__main__":
    create_concept_diagram()
EOF

    # Create Python files for lab diagrams
    cat > "$BASE_DIR/$topic/$diagram_name/labs/${topic#*-}_lab.py" <<EOF
from diagrams import Diagram, Cluster
from diagrams.programming.framework import Terraform
from diagrams.aws.compute import EC2
from diagrams.aws.network import VPC

# Lab architecture diagrams for ${topic#*-}
def create_lab_diagram():
    with Diagram("${topic#*-} Lab Architecture", show=False):
        # Add diagram components here
        pass

if __name__ == "__main__":
    create_lab_diagram()
EOF

    # Create README for diagrams
    cat > "$BASE_DIR/$topic/$diagram_name/README.md" <<EOF
# ${topic#*-} Diagrams

## Theory Diagrams
Located in \`theory/\` directory:
- ${topic#*-} concept diagrams
- Architecture overviews
- Workflow illustrations

## Lab Diagrams
Located in \`labs/\` directory:
- ${topic#*-} lab environment setup
- Step-by-step workflow
- Resource relationships

## Requirements
- Python 3.7+
- diagrams library (\`pip install diagrams\`)
- Graphviz (\`apt-get install graphviz\` or \`brew install graphviz\`)
EOF

done

echo "Fresh directory structure created successfully!"
