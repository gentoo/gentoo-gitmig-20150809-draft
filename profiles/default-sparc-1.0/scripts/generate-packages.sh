#!/bin/sh
#
# $Header: /var/cvsroot/gentoo-x86/profiles/default-sparc-1.0/scripts/generate-packages.sh,v 1.7 2002/05/08 01:23:05 murphy Exp $
#
# New packages file
NEWPACKAGESBUILD=packages.build
NEWUSEDEFAULTS=use.defaults
NEWPACKAGES=packages
NEWDEFAULTS=make.defaults
NEWVIRTUALS=virtuals

KEEPPACKAGESBUILD=.packages.build.keep
KEEPUSEDEFAULTS=.use.defaults.keep
KEEPPACKAGES=.packages.keep
KEEPDEFAULTS=.make.defaults.keep
KEEPVIRTUALS=.virtuals.keep

# Sanity checks
if [ ! -r packages.sparc ]
then
	echo This script must be run from the /usr/portage/profiles/default-sparc-* tree.
	exit 1
fi

# Variables
from_version=1.0
from_dir=../default-${from_version}


# 1) Make our own packages version
cp -p $NEWPACKAGES $KEEPPACKAGES
echo "# This file created automagically by $0 on `date`" > $NEWPACKAGES
echo "" >> $NEWPACKAGES
sed -e 's:.*sys-apps/grub:#*sys-apps/grub:' \
	-e 's:.*sys-devel/bin86:#*sys-devel/bin86:' \
	-e 's:.*sys-apps/lilo:#*sys-apps/lilo:' \
	-e 's:[^#]*sys-kernel/linux-headers.*:~sys-kernel/linux-headers-2.4.18:' \
	-e 's:[^#]*x11-base/xfree.*:<x11-base/xfree-4.2.0:' \
	${from_dir}/packages >> $NEWPACKAGES
cat >> $NEWPACKAGES <<_EOF_

# These lines added by $0
_EOF_
cat >> $NEWPACKAGES < packages.sparc
cat >> $NEWPACKAGES <<_EOF_
# End of lines added by $0
_EOF_


# 2) Update make.defaults
cp -p $NEWDEFAULTS $KEEPDEFAULTS
echo "# This file created automagically by $0 on `date`" > $NEWDEFAULTS
echo "" >> $NEWDEFAULTS
sed -e 's:ARCH=.*::' ${from_dir}/make.defaults >> $NEWDEFAULTS
cat >> $NEWDEFAULTS <<_EOF_

# These lines added by $0
_EOF_
cat >> $NEWDEFAULTS < make.defaults.sparc
cat >> $NEWDEFAULTS <<_EOF_
# End of lines added by $0
_EOF_

# 3) use.defaults
cp -p $NEWUSEDEFAULTS $KEEPUSEDEFAULTS
cp -p ${from_dir}/use.defaults $NEWUSEDEFAULTS

# 4) packages.build
cp -p $NEWPACKAGESBUILD $KEEPPACKAGESBUILD
cp -p ${from_dir}/packages.build $NEWPACKAGESBUILD

# 5) virtuals
cp -p $NEWVIRTUALS $KEEPVIRTUALS
cp -p ${from_dir}/virtuals $NEWVIRTUALS

