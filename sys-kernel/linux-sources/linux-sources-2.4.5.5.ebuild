# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# /home/cvsroot/gentoo-x86/sys-kernel/linux/linux-2.4.4.3.ebuild,v 1.1 2001/05/02 14:31:06 achim Exp

# *** WARNING: This kernel package does not have XFS support! ***

#OKV=original kernel version, KV=patched kernel version
OKV=2.4.5
KV=2.4.5-ac5

if [ "${PN}" = "linux-extras" ]
then
    S=/usr/src/linux-${KV}
else
    S=${WORKDIR}/linux-${KV}
fi

# Versions of LVM
LVMV=0.9.1_beta7

LVMVARC=0.9.1_beta7
# Versions of alsa
AV=0.5.11

# Versionos of jfs
JFSV=0.2.1

# Versions of lm_sensors and i2c
SENV=20010530-gentoo
I2CV=20010530-gentoo

# Versions of reiserfs
RV=20010327
KNV="6.g"
PIV="1.d"

# Versions of xmlprocfs
XMLV=0.3

# Versions of pcmcia-cs
PCV="3.1.25"

# Version of XFS
XFSV=20010530-gentoo

[ "${PN}" = "linux" ] && DESCRIPTION="Linux kernel version ${KV}, including modules, binary tools, libraries and includes"
[ "${PN}" = "linux-sources" ] && DESCRIPTION="Linux kernel version ${KV} - full sources"
[ "${PN}" = "linux-extras" ] && DESCRIPTION="Linux kernel support tools and libraries"

# We use build in /usr/src/linux in case of linux-extras
# so we need no sources
if [ "${PN}" != "linux-extras" ]
then
    SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	     http://www.kernel.org/pub/linux/kernel/people/alan/2.4/patch-${KV}.bz2
	     http://dice.mfa.kfki.hu/download/reiserfs-3.6.25-${OKV}/linux-2.4.5-pre6-knfsd.patch.bz2
	     http://dice.mfa.kfki.hu/download/reiserfs-3.6.25-${OKV}/reiserfs-quota-2.4.4.dif.bz2"

#	     http://dice.mfa.kfki.hu/download/reiserfs-3.6.25-${OKV}/bigpatch-${OKV}.diff.bz2
#	     http://oss.software.ibm.com/developerworks/opensource/jfs/project/pub/jfs-${JFSV}-patch.tar.gz
#	     http://download.sourceforge.net/xmlprocfs/linux-2.4-xmlprocfs-${XMLV}.patch.gz
#	     ftp://ftp.reiserfs.com/pub/reiserfs-for-2.4/linux-${OKV}-reiserfs-${RV}.patch.gz
    
    if [ "`use i2c`" ] || [ "`use lm_sensors`" ]
    then
#	SRC_URI="${SRC_URI} http://www.netroedge.com/~lm78/archive/i2c-${I2CV}.tar.gz"
	SRC_URI="${SRC_URI} ftp://ftp.ibiblio.org/pub/Linux/distributions/gentoo/gentoo-sources/i2c-${I2CV}.tar.gz"
    fi
    if [ "`use lm_sensors`" ]
    then
#	SRC_URI="${SRC_URI} http://www.netroedge.com/~lm78/archive/lm_sensors-${SENV}.tar.gz"
	SRC_URI="${SRC_URI} ftp://ftp.ibiblio.org/pub/Linux/distributions/gentoo/gentoo-sources/lm_sensors-${SENV}.tar.gz"
    fi
    if [ "`use lvm`" ]
    then
	SRC_URI="${SRC_URI} ftp://ftp.sistina.com/pub/LVM/0.9.1_beta/lvm_${LVMVARC}.tar.gz"
    fi
    if [ "`use alsa`" ]
    then 
	SRC_URI="${SRC_URI} ftp://ftp.alsa-project.org/pub/driver/alsa-driver-${AV}.tar.bz2"
    fi
    if [ "`use pcmcia-cs`" ]
    then
	SRC_URI="${SRC_URI} http://prdownloads.sourceforge.net/pcmcia-cs/pcmcia-cs-${PCV}.tar.gz"
    fi
#### XFS
#    if [ "`use xfs`" ]
#    then
#	SRC_URI="${SRC_URI} ftp://ftp.ibiblio.org/pub/Linux/distributions/gentoo/gentoo-sources/linux-${KV}-xfs-${XFSV}.diff.gz"
#    fi
#### XFS
fi

if [ "${PN}" = "linux-extras" ]
then
    DEPEND=">=sys-kernel/linux-sources-${PVR}"
    RDEPEND=" "
#### XFS
#    if [ "`use xfs`" ]
#    then
#	DEPEND="${DEPEND} >=sys-devel/autoconf-2.13"
#    fi
#### XFS
    if [ "`use alsa`" ]
    then
	PROVIDE="virtual/alsa"
    fi
elif [ "${PN}" = "linux" ]
then
    PROVIDE="virtual/kernel"
    RDEPEND=">=sys-apps/reiserfs-utils-3.6.25-r1"
    DEPEND=">=sys-apps/modutils-2.4.2
	    >=sys-devel/flex-2.5.4a-r3
	    >=dev-util/yacc-1.9.1-r1"
#### XFS
#    if [ "`use xfs`" ]
#    then
#	DEPEND="${DEPEND} >=sys-devel/autoconf-2.13"
#    fi
#### XFS
    if [ "`use alsa`" ]
    then
	PROVIDE="${PROVIDE} virtual/alsa"
    fi
fi

HOMEPAGE="http://www.kernel.org/
	  http://www.netroedge.com/~lm78/
	  http://www.namesys.com
	  http://www.sistina.com/lvm/
	  http://www.alsa-project.org
	  http://pcmcia-cs.sourceforge.net
	  http://linux-xfs.sgi.com/projects/xfs/"

# this is not pretty...
LINUX_HOSTCFLAGS="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -I${S}/include"

src_unpack() {
    
    # We only need to unpack for linux and linux-sources

    if [ "${PN}" != "linux-extras" ]
    then
	
	#unpack kernel and apply reiserfs-related patches
	cd ${WORKDIR}
	unpack linux-${OKV}.tar.bz2
	try mv linux linux-${KV}
	cd ${S}
	
	# save this for later...
	cp -a drivers/md/lvm-snap.h ${T}
	
	echo "Applying ${KV} patch..."
	try bzip2 -dc ${DISTDIR}/patch-${KV}.bz2 | patch -p1
	
	echo "Applying reiserfs-knfsd patch..."
#	try gzip -dc ${DISTDIR}/linux-${OKV}-knfsd-${KNV}.patch.gz | patch -p1
	try bzip2 -dc ${DISTDIR}/linux-2.4.5-pre6-knfsd.patch.bz2 | patch -p1
	
#	echo "Applying reiserfs-procinfo patch..."
#	try gzip -dc ${DISTDIR}/linux-${OKV}-procinfo-${PIV}.patch.gz | patch -p1
	
	echo "Applying reiserfs-quota patch..."
#	try bzip2 -dc ${DISTDIR}/reiserfs-quota-${OKV}.dif.bz2 | patch -p1
	try bzip2 -dc ${DISTDIR}/reiserfs-quota-2.4.4.dif.bz2 | patch -p1
	
#	echo "Applying reiserfs patches..."
#	try bzip2 -dc ${DISTDIR}/bigpatch-${OKV}.diff.bz2 | patch -p1
	
	echo "Applying ${KV}-reiserfs-quota patch..."
	try patch -p1 < ${FILESDIR}/${PVR}/linux-${KV}-reiserfs-quota-gentoo.diff
	
	if [ "`use lvm`" ] || [ "`use alsa`" ] || [ "`use i2c`" ] || [ "`use lm_sensors`" ] || [ "`use pcmcia-cs`" ]
	then
	    mkdir -p ${S}/extras
	fi
	
#### XFS
#	if [ "`use xfs`" ]
#	then
#	    cd ${S}
#	    echo "Applying xfs patch..."
#	    try gzip -dc ${DISTDIR}/linux-${KV}-xfs-${XFSV}.diff.gz | patch -p1
#	fi
#### XFS
	
	if [ "`use lvm`" ]
	then
	    #create and apply LVM patch.  The tools get built later.
	    cd ${S}/extras
	    echo "Unpacking and applying LVM patch..."
	    unpack lvm_${LVMVARC}.tar.gz
	    try cd LVM/${LVMV}
	    
	    # I had to hack this in so that LVM will look in the current linux
	    # source directory instead of /usr/src/linux for stuff - pete
	    try CFLAGS=\""${CFLAGS} -I${S}/include"\" ./configure --prefix=/ --mandir=/usr/share/man --with-kernel_dir="${S}"
	    
	    cd PATCHES
	    try make KERNEL_VERSION=${KV} KERNEL_DIR=${S}
	    cd ${S}
	    patch -p1 < ${FILESDIR}/${PVR}/linux-${KV}-gentoo-pre-lvm.diff
	    mv -f ${T}/lvm-snap.h drivers/md
#### XFS
#	    if [ "`use xfs`" ]
#	    then
#		try patch -l -p1 < ${FILESDIR}/${PVR}/linux-${KV}-xfs-${XFSV}-pre-lvm.diff
#	    fi
#### XFS
	    # the -l option allows this patch to apply cleanly (ignore whitespace changes)
	    try patch -l -p1 < ${S}/extras/LVM/${LVMV}/PATCHES/lvm-${LVMV}-${KV}.patch
	    cd ${S}/drivers/md
	    try patch -p0 < ${FILESDIR}/${PVR}/lvm.c.diff
	fi
	
	if [ "`use alsa`" ]
	then  
	    #unpack alsa drivers
	    echo "Unpacking ALSA drivers..."
	    cd ${S}/extras
	    unpack alsa-driver-${AV}.tar.bz2
	fi
	
	if [ "`use i2c`" ] || [ "`use lm_sensors`" ]
	then
	    if [ -z "`use i2c`" ]
	    then
		echo "Note: Using i2c since lm_sensors is enabled."
	    fi
	    #unpack and apply the i2c patch
	    echo "Unpacking and applying i2c patch..."
	    cd ${S}/extras
	    unpack i2c-${I2CV}.tar.gz
	    try cd i2c-${I2CV}
	    try mkpatch/mkpatch.pl . ${S} > ${S}/i2c-patch
	    try cp -a Makefile Makefile.orig
	    
	    cd ${S}
	    try patch -p1 < i2c-patch
	    rm -f i2c-patch
	fi
	
	if [ "`use lm_sensors`" ]
	then
	    #unpack and apply the lm_sensors patch
	    echo "Unpacking and applying lm_sensors patch..."
	    cd ${S}/extras
	    unpack lm_sensors-${SENV}.tar.gz
	    try cd lm_sensors-${SENV}
	    try mkpatch/mkpatch.pl . ${S} > ${S}/lm_sensors-patch
	    try rmdir src
	    try ln -s ../.. src
	    try cp -a Makefile Makefile.orig
	    
	    cd ${S}
	    try patch -p1 < lm_sensors-patch
	    rm -f lm_sensors-patch
	fi
	
#### XFS
#	if [ "`use xfs`" ]
#	then
#	    echo "Applying xfs cleanup patch..."
#	    try patch -p1 < ${FILESDIR}/${PVR}/linux-${KV}-xfs-${XFSV}-cleanup.diff
#	fi
#### XFS
	
	if [ "`use pcmcia-cs`" ]
	then
	    echo "Unpacking pcmcia-cs tools..."
	    cd ${S}/extras
	    unpack pcmcia-cs-${PCV}.tar.gz
	    patch -p0 < ${FILESDIR}/${PVR}/pcmcia-cs-${PCV}-gentoo.diff
	fi
	#get sources ready for compilation or for sitting at /usr/src/linux
	echo "Preparing for compilation..."
	
	cd ${S}
	
	#sometimes we have icky kernel symbols; this seems to get rid of them
	try make mrproper
	
	#fix silly permissions in tarball
	cd ${WORKDIR}
	chown -R 0.0 ${S}
	chmod -R a+r-w+X,u+w ${S}
    fi
}

src_compile() {

    if [ "${PN}" != "linux-sources" ]
    then
	if [ "${PN}" = "linux" ]
	then
	    #this is the configuration for the default kernel
	    try cp ${FILESDIR}/${PVR}/config.bootcomp .config
	    try yes \"\" \| make oldconfig
	    echo "Ignore any errors from the yes command above."
	    try make include/linux/version.h
	fi
	
	if [ "$PN" = "linux" ]
	then
	    try make symlinks
	fi
	
	if [ "`use lvm`" ]
	then
	    #LVM tools are included in the linux and linux-extras pakcages
	    cd ${S}/extras/LVM/${LVMV}

	    # This is needed for linux-extras
	    if [ -f "Makefile" ]
	    then
		try make distclean
	    fi
	    # I had to hack this in so that LVM will look in the current linux
	    # source directory instead of /usr/src/linux for stuff - pete
	    try CFLAGS=\""${CFLAGS} -I${S}/include"\" ./configure --prefix=/ --mandir=/usr/share/man --with-kernel_dir="${S}"
	    
	    try make 
	fi
	
	if [ "`use i2c`" ] || [ "`use lm_sensors`" ]
	then
	    cd ${S}/extras/i2c-${I2CV}
 	    try sed -e \''s:^LINUX=.*:LINUX=src:'\' \
		-e \''s/^COMPILE_KERNEL.*/COMPILE_KERNEL := 0/'\' \
		-e \''s:^I2C_HEADERS.*:I2C_HEADERS=src/include:'\' \
		-e \'"s#^DESTDIR.*#DESTDIR := ${D}#"\' \
		Makefile.orig > Makefile
	    
	    try make clean
	    
	    try make
	fi
	
	if [ "`use lm_sensors`" ]
	then
	    cd ${S}/extras/lm_sensors-${SENV}
 	    try sed -e \''s:^LINUX=.*:LINUX=src:'\' \
		-e \''s/^COMPILE_KERNEL.*/COMPILE_KERNEL := 0/'\' \
		-e \''s:^I2C_HEADERS.*:I2C_HEADERS=src/include:'\' \
		-e \'"s#^DESTDIR.*#DESTDIR := ${D}#"\' \
		-e \''s#^PREFIX.*#PREFIX := /usr#'\' \
		-e \''s#^MANDIR.*#MANDIR := /usr/share/man#'\' \
		Makefile.orig > Makefile
	    
	    try make clean
	    
	    try make
	fi
	
#### XFS
#	if [ "`use xfs`" ]
#	then
#	    cd ${S}/extras/xfs-${XFSV}/acl
#	    try make distclean
#	    rm -f include/builddefs
#	    try make \
#		CPPFLAGS=\""-I${S}/include"\" \
#		configure
#	    try make \
#		PKG_SBIN_DIR=/sbin \
#		PKG_INC_DIR=/usr/include/acl \
#		PKG_LIB_DIR=/usr/lib \
#		PKG_MAN_DIR=/usr/share/man \
#		CC=\""gcc -I${S}/include"\" \
#		OPTIMIZER=\""${CFLAGS}"\" \
#		DEBUG=\"\"
#	    
#	    cd ${S}/extras/xfs-${XFSV}/attr
#	    try make distclean
#	    rm -f include/builddefs
#	    try make \
#		CPPFLAGS=\""-I${S}/include"\" \
#		configure
#	    try make \
#		PKG_SBIN_DIR=/bin \
#		PKG_INC_DIR=/usr/include/acl \
#		PKG_LIB_DIR=/usr/lib \
#		PKG_MAN_DIR=/usr/share/man \
#		CC=\""gcc -I${S}/include"\" \
#		OPTIMIZER=\""${CFLAGS}"\" \
#		DEBUG=\"\"
#	    
#	    cd ${S}/extras/xfs-${XFSV}/xfsprogs
#	    try make distclean
#	    rm -f include/builddefs
#	    try make \
#		CPPFLAGS=\""-I${S}/include"\" \
#		configure
#	    try make \
#		PKG_SBIN_DIR=/sbin \
#		PKG_BIN_DIR=/usr/sbin \
#		PKG_INC_DIR=/usr/include/xfs \
#		PKG_LIB_DIR=/usr/lib \
#		PKG_MAN_DIR=/usr/share/man \
#		CC=\""gcc -I${S}/include"\" \
#		OPTIMIZER=\""${CFLAGS}"\" \
#		DEBUG=\"\"
#	    
#	    # dmapi and xfsdump must be built last, cuz they depend on libattr (in attr) and libxfs (in xfsprogs)
#	    cd ${S}/extras/xfs-${XFSV}/dmapi
#	    ln -sf ../../xfsprogs/include include/xfs
#	    try make distclean
#	    rm -f include/builddefs
#	    try make \
#		CPPFLAGS=\""-I${S}/include -I${S}/extras/xfs-${XFSV}/dmapi/include"\" \
#		configure
#	    try make \
#		PKG_INC_DIR=/usr/include/dmapi \
#		PKG_LIB_DIR=/usr/lib \
#		PKG_MAN_DIR=/usr/share/man \
#		CC=\""gcc -I${S}/include"\" \
#		OPTIMIZER=\""${CFLAGS}"\" \
#		DEBUG=\"\"
#		
#	    cd ${S}/extras/xfs-${XFSV}/xfsdump
#	    ln -sf ../../xfsprogs/include include/xfs
#	    ln -sf ../../attr/include include/attr
#	    try make distclean
#	    rm -f include/builddefs
#	    try make \
#		CPPFLAGS=\""-I${S}/include -I${S}/extras/xfs-${XFSV}/xfsdump/include -I${S}/extras/xfs-${XFSV}/xfsprogs/include -I${S}/extras/xfs-${XFSV}/attr/include"\" \
#		LDFLAGS=\""-L${S}/extras/xfs-${XFSV}/attr/libattr -L${S}/extras/xfs-${XFSV}/xfsprogs/libxfs -L${S}/extras/xfs-${XFSV}/xfsprogs/libhandle -lhandle"\" \
#		configure
#	    try make \
#		PKG_BIN_DIR=/usr/sbin \
#		PKG_LIB_DIR=/usr/lib \
#		PKG_MAN_DIR=/usr/share/man \
#		CC=\""gcc -I${S}/include -I${S}/extras/xfs-${XFSV}/xfsprogs/include -I${S}/extras/xfs-${XFSV}/attr/include"\" \
#		OPTIMIZER=\""${CFLAGS}"\" \
#		DEBUG=\"\" \
#		LIBATTR=\""-L${S}/extras/xfs-${XFSV}/attr/libattr -lattr"\" \
#		LIBXFS=\""-L${S}/extras/xfs-${XFSV}/xfsprogs/libxfs -lxfs"\" \
#		LIBHANDLE=\""-L${S}/extras/xfs-${XFSV}/xfsprogs/libhandle -lhandle"\"
#	    
#	fi
#### XFS
	
	cd ${S}
	
	if [ "${PN}" == "linux" ]
	then
	    try make HOSTCFLAGS=\""${LINUX_HOSTCFLAGS}"\" dep
	    try make HOSTCFLAGS=\""${LINUX_HOSTCFLAGS}"\" LEX=\""flex -l"\" bzImage
		#LEX=\""flex -l"\" bzImage
	    try make HOSTCFLAGS=\""${LINUX_HOSTCFLAGS}"\" LEX=\""flex -l"\" modules
		#LEX=\""flex -l"\" modules
	    
	fi
	# This must come after the kernel compilation in linux
	if [ "`use alsa`" ]
	then
	    cd ${S}/extras/alsa-driver-${AV}
	    # This is needed for linux-extras
	    if [ -f "Makefile.conf" ]
	    then
		try make mrproper
	    fi
	    try ./configure --with-kernel=\"${S}\" --with-isapnp=yes --with-sequencer=yes --with-oss=yes --with-cards=all
	    mkdir -p modules
	    try make
	fi
	if [ "`use pcmcia-cs`" ]
	then
	    cd ${S}/extras/pcmcia-cs-${PCV}
	    # This is needed for linux-extras
	    if [ -f "Makefile" ]
	    then
		try make clean
	    fi
	    try ./Configure -n --kernel=${S} --moddir=/lib/modules/${KV} \
		--notrust --cardbus --nopnp --noapm --srctree --sysv --rcdir=/etc/rc.d/
	    try make all
	fi
    fi
}

src_install() {

    # We install the alsa headers in all three packages
    if [ "`use alsa`" ]
    then
	# get alsa includes
	cd ${S}/extras/alsa-driver-${AV}
	insinto /usr/src/linux-${KV}/include/linux
	cd include
	doins asound.h asoundid.h asequencer.h ainstr_*.h
    fi

    if [ "${PN}" != "linux-sources" ]
    then
	dodir /usr/lib
	
	if [ "`use lvm`" ]
	then
	    cd ${S}/extras/LVM/${LVMV}/tools
	    
	    try CFLAGS=\""${CFLAGS} -I${S}/include"\" make install -e prefix=${D} mandir=${D}/usr/share/man \
		sbindir=${D}/sbin libdir=${D}/lib
	    #no need for a static library in /lib
	    mv ${D}/lib/*.a ${D}/usr/lib
	    
	    cd ${S}/extras/LVM/${LVMV}
	    docinto LVM-${LVMV}
	    dodoc ABSTRACT CHANGELOG CONTRIBUTORS COPYING COPYING.LIB FAQ KNOWN_BUGS LVM-HOWTO
	    dodoc README TODO WHATSNEW
	fi
	
	if [ "`use lm_sensors`" ]
	then
	    echo "Install sensor tools..."
	    #install sensors tools
	    cd ${S}/extras/lm_sensors-${SENV}
	    make install
	    docinto lm_sensors-${SENV}
	    dodoc BACKGROUND BUGS CHANGES CONTRIBUTORS COPYING INSTALL QUICKSTART README
	fi
	
#### XFS
#	if [ "`use xfs`" ]
#	then
#	    cd ${S}/extras/xfs-${XFSV}/acl
#	    chmod +x install-sh
#	    try make \
#		PKG_SBIN_DIR=${D}/sbin \
#		PKG_INC_DIR=${D}/usr/include/acl \
#		PKG_LIB_DIR=${D}/usr/lib \
#		PKG_MAN_DIR=${D}/usr/share/man \
#		install install-dev
#	    rm -rf ${D}/usr/share/doc/acl
#	    docinto xfs-${XFSV}/acl
#	    dodoc README doc/CHANGES doc/COPYING doc/PORTING
#	    
#	    cd ${S}/extras/xfs-${XFSV}/attr
#	    chmod +x install-sh
#	    try make \
#		PKG_SBIN_DIR=${D}/bin \
#		PKG_INC_DIR=${D}/usr/include/acl \
#		PKG_LIB_DIR=${D}/usr/lib \
#		PKG_MAN_DIR=${D}/usr/share/man \
#		install install-dev
#	    rm -rf ${D}/usr/share/doc/attr
#	    docinto xfs-${XFSV}/attr
#	    dodoc README doc/CHANGES doc/COPYING doc/PORTING
#	    
#	    cd ${S}/extras/xfs-${XFSV}/xfsprogs
#	    chmod +x install-sh
#	    try make \
#		PKG_SBIN_DIR=${D}/sbin \
#		PKG_BIN_DIR=${D}/usr/sbin \
#		PKG_INC_DIR=${D}/usr/include/xfs \
#		PKG_LIB_DIR=${D}/usr/lib \
#		PKG_MAN_DIR=${D}/usr/share/man \
#		install install-dev
#	    rm -rf ${D}/usr/share/doc/xfsprogs
#	    docinto xfs-${XFSV}/xfsprogs
#	    dodoc README doc/CHANGES doc/COPYING docs/CREDITS doc/PORTING doc/README.LVM doc/README.quota
#	    
#	    cd ${S}/extras/xfs-${XFSV}/dmapi
#	    chmod +x install-sh
#	    try make \
#		PKG_INC_DIR=${D}/usr/include/dmapi \
#		PKG_LIB_DIR=${D}/usr/lib \
#		PKG_MAN_DIR=${D}/usr/share/man \
#		install install-dev
#	    rm -rf ${D}/usr/share/doc/dmapi
#	    docinto xfs-${XFSV}/dmapi
#	    dodoc README doc/CHANGES doc/COPYING doc/PORTING
#	    
#	    cd ${S}/extras/xfs-${XFSV}/xfsdump
#	    chmod +x install-sh
#	    try make \
#		PKG_BIN_DIR=${D}/usr/sbin \
#		PKG_LIB_DIR=${D}/usr/lib \
#		PKG_MAN_DIR=${D}/usr/share/man \
#		install install-dev
#	    rm -rf ${D}/usr/share/doc/xfsprogs
#	    docinto xfs-${XFSV}/xfsdump
#	    dodoc README doc/CHANGES doc/COPYING doc/PORTING doc/README.xfsdump
#	fi
#### XFS
	
	if [ "${PN}" = "linux" ] 
	then
	    dodir /usr/src
    	    
	    dodir /usr/src/linux-${KV}
	    cd ${D}/usr/src
	    #grab includes and documentation only
	    echo ">>> Copying includes and documentation..."
	    find ${S}/include ${S}/Documentation -type f -name "*~" -exec rm -vf {} \;
	    cp -ax ${S}/include ${D}/usr/src/linux-${KV}
	    cp -ax ${S}/Documentation ${D}/usr/src/linux-${KV}
	    
	    #grab compiled kernel
	    dodir /boot/boot
	    insinto /boot/boot
	    cd ${S}
	    doins arch/i386/boot/bzImage
	    
	    #grab modules
	    # Do we have a bug in modutils ?
	    # Meanwhile we use this quick fix (achim)
	    
	    install -d ${D}/lib/modules/`uname -r`
	    try make INSTALL_MOD_PATH=${D} modules_install
	    
	    depmod -b ${D} -F ${S}/System.map ${KV}	
#	    rm -rf ${D}/lib/modules/`uname -r`
  	    #fix symlink
	    cd ${D}/lib/modules/${KV}
	    rm build
	    ln -sf /usr/src/linux-${KV} build
	fi
	
        if [ "`use alsa`" ]
        then
            cd ${S}/extras/alsa-driver-${AV}
	    docinto alsa-${AV}
	    dodoc COPYING INSTALL FAQ README WARNING
	    docinto alsa-${AV}/doc
	    dodoc doc/README.1st doc/SOUNDCARDS
	    mkdir -p ${D}/lib/modules/${KV}/misc
	    cp modules/*.o ${D}/lib/modules/${KV}/misc
        fi
	if [ "`use pcmcia-cs`" ]
	then
	    #install PCMCIA modules and utilities
	    cd ${S}/extras/pcmcia-cs-${PCV}
	    try make PREFIX=${D} install
	    rm -rf ${D}/etc/rc.d
	    exeinto /etc/rc.d/init.d
	    doexe ${FILESDIR}/${PVR}/pcmcia
	    docinto pcmcia-cs-${PCV}
	    dodoc BUGS CHANGES COPYING LICENSE MAINTAINERS README README-2.4 SUPPORTED.CARDS
	    cd doc ; docinto pcmcia-cs-${PCV}/doc
	    dodoc PCMCIA-HOWTO PCMCIA-HOWTO.ps PCMCIA-PROG PCMCIA-PROG.ps
	fi
    else
	dodir /usr/src
    	
	cd ${S}
	make mrproper
	
	if [ "`use lvm`" ]
	then
	    cd ${S}/extras/LVM/${LVMV}
	    if [ -f Makefile ]
	    then
		make distclean
	    fi
	fi
	if [ "`use lm_sensors`" ]
	then
	    cd ${S}/extras/lm_sensors-${SENV}
	    make clean
	fi
		
	echo ">>> Copying sources..."
	find ${S} -type f -name "*~" -exec rm -vf {} \;
	cp -ax ${S} ${D}/usr/src
	
	#don't overwrite existing .config if present
	cd ${D}/usr/src/linux-${KV}
	if [ -e .config ]
	then
	    cp -a .config .config.eg
	fi
    fi
}

pkg_postinst() {
    if [ "${PN}" != "linux-extras" ]
    then
	rm -f ${ROOT}/usr/src/linux
	ln -sf linux-${KV} ${ROOT}/usr/src/linux
    fi
    
    #copy over our .config if one isn't already present
    cd ${ROOT}/usr/src/linux-${KV}
    if [ "${PN}" = "linux-sources" ] && [ -e .config.eg ] && [ ! -e .config ]
    then
	cp -a .config.eg .config
    fi
}
