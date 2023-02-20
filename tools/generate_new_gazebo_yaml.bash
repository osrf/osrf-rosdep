GZ_DISTRO=${1}
VERSIONS=$(curl -SS https://raw.githubusercontent.com/gazebo-tooling/gazebodistro/master/collection-${GZ_DISTRO}.yaml | grep version | awk '{ print $2 }')

PYTHON_LIBS="sdformat sim math"
# This does not match the packages having a cli executable but the just
# utils cli COMPONENT -dev package. Following the one existing in the rosdistro
# at the time of Fortress
CLI_LIBSS="utils"

for version in $VERSIONS; do
  # Handle sdformat
  [[ ${version} != ${version/sdf/} ]] && version="${version/sdf/sdformat}"
  # 1. Main lib-dev keys
  echo "$version:"
  echo "  ubuntu: [lib${version}-dev]"
  # 2. Python bindings
  for python_lib in $PYTHON_LIBS; do
    if [[ ${version} != ${version/$python_lib/} ]]; then
      pkg_name="python3-${version}"
      echo "$pkg_name:"
      echo "  ubuntu: [${pkg_name}]"
    fi
  done
  # 3. cli package
  for clilib in $CLI_LIBSS; do
    if [[ ${version} != ${version/$clilib/} ]]; then
      echo "${version}-cli:"
      echo "  ubuntu: [lib${version}-cli-dev]"
    fi
  done
done
