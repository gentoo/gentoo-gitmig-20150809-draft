#!/bin/sh
#
# $Header: /var/cvsroot/gentoo-x86/profiles/default-sparc-1.0/scripts/generate-packages.sh,v 1.10 2003/12/09 08:40:00 seemant Exp $
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
	#-e 's:[^#]*x11-base/xfree.*:<x11-base/xfree-4.2.0:' \
sed -e 's:.*sys-boot/grub:#*sys-boot/grub:' \
	-e 's:.*sys-devel/bin86:#*sys-devel/bin86:' \
	-e 's:.*sys-boot/lilo:#*sys-boot/lilo:' \
	-e 's:[^#]*sys-kernel/linux-headers.*:~sys-kernel/linux-headers-2.4.18:' \
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
sed -e 's:ARCH=.*::' -e 's:ACCEPT_KEYWORDS=.*::' \
	 ${from_dir}/make.defaults >> $NEWDEFAULTS
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

