# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-extras/linux-extras-2.4.4-r1.ebuild,v 1.1 2001/04/30 16:29:06 pete Exp $

#OKV=original kernel version, KV=patched kernel version
OKV=2.4.4
KV=2.4.4
S=${WORKDIR}/linux-${KV}
#Versions of LVM, ALSA, JFS and lm-sensors
LVMV=0.9.1_beta7
LVMVARC=0.9.1_beta7
AV=0.5.10b
JFSV=0.2.1
SENV=2.5.5
RV=20010327
XMLV=0.3
KNV="6.g"

[ "${PN}" = "linux" ] && DESCRIPTION="Linux kernel version ${KV}, including modules, binary tools, libraries and includes"
[ "${PN}" = "linux-sources" ] && DESCRIPTION="Linux kernel version ${KV} - full sources"
[ "${PN}" = "linux-extras" ] && DESCRIPTION="Linux kernel support tools and libraries"

SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2"
#        http://oss.software.ibm.com/developerworks/opensource/jfs/project/pub/jfs-${JFSV}-patch.tar.gz
#	 http://download.sourceforge.net/xmlprocfs/linux-2.4-xmlprocfs-${XMLV}.patch.gz
#	 ftp://ftp.reiserfs.com/pub/reiserfs-for-2.4/linux-${OKV}-reiserfs-${RV}.patch.gz

[ "`use lm_sensors`" ] && SRC_URI="${SRC_URI} http://www.netroedge.com/~lm78/archive/lm_sensors-${SENV}.tar.gz"
[ "`use lvm`" ] && SRC_URI="${SRC_URI} ftp://ftp.sistina.com/pub/LVM/0.9.1_beta/lvm_${LVMVARC}.tar.gz"
[ "`use alsa`" ] && SRC_URI="${SRC_URI} ftp://ftp.alsa-project.org/pub/driver/alsa-driver-${AV}.tar.bz2"

HOMEPAGE="http://www.kernel.org/
	  http://www.netroedge.com/~lm78/
	  http://www.namesys.com
	  http://www.sistina.com/lvm/
	  http://www.alsa-project.org"

[ "${PN}" = "linux" ] || [ "${PN}" = "linux-sources" ] && PROVIDE="virtual/kernel"

RDEPEND=">=sys-apps/reiserfs-utils-3.6.25-r1"
DEPEND="dev-util/yacc sys-devel/flex >=sys-apps/modutils-2.4.0"

# this is not pretty...
LINUX_HOSTCFLAGS="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -I${S}/include"

if [ "`use lvm`" ]
then
    echo '*** AaCCkK!! Right now, LVM is broken with this kernel.'
    echo '*** If you don't use LVM, remove lvm from your USE variable.'
    echo '*** If you DO use LVM, don't use this kernel package.'
    echo '*** AFAIK, This kernel *is* safe to use without LVM.'
    exit 1
fi

src_unpack() {
    #unpack kernel and apply reiserfs-related patches
    cd ${WORKDIR}
    unpack linux-${OKV}.tar.bz2
    mv linux linux-${KV}
    cd ${S}
    
#    echo "Applying ${KV} patch..."
#    try bzip2 -dc ${DISTDIR}/patch-${KV}.bz2 | patch -p1
#    echo "Applying reiserfs-update patch..."
#    try gzip -dc ${DISTDIR}/linux-2.4.2-reiserfs-${RV}.patch.gz | patch -N -p1
#    echo "You can ignore the rejects the changes already are in rc11"

#    echo
#    echo "Applying xmlprocfs patch..."
#    try gzip -dc ${DISTDIR}/linux-2.4-xmlprocfs-${XMLV}.patch.gz | patch -p1   
#    echo "Applying reiserfs-knfsd patch..."
#    try gzip -dc ${DISTDIR}/linux-${OKV}-knfsd-${KNV}.patch.gz | patch -p1
    
    if [ "`use lvm`" ] || [ "`use alsa`" ] || [ "`use lm_sensors`" ]
    then
	mkdir ${S}/extras
    fi
    
    if [ "`use lvm`" ]
    then
	#create and apply LVM patch.  The tools get built later.
	cd ${S}/extras
	echo "Unpacking and applying LVM patch..."
	unpack lvm_${LVMVARC}.tar.gz
	cd LVM/${LVMV}
	
	# I had to hack this in so that LVM will look in the current linux
	# source directory instead of /usr/src/linux for stuff - pete
	#    try CFLAGS=\""${CFLAGS} -I${S}/include"\" ./configure --prefix=/ --mandir=/usr/share/man --with-kernel_dir="${S}"
	
	cd PATCHES
	try make KERNEL_VERSION=${KV} KERNEL_DIR=${S}
	cd ${S}
	# the -l option allows this patch to apply cleanly (ignore whitespace changes)
	try patch -l -p1 < ${S}/extras/LVM/${LVMV}/PATCHES/lvm-${LVMV}-${KV}.patch
    fi
    
    if [ "`use alsa`" ]
    then  
        #unpack alsa drivers
        echo "Unpacking ALSA drivers..."
        cd ${S}/extras
        unpack alsa-driver-${AV}.tar.bz2
    fi
    
    if [ "`use lm_sensors`" ]
    then
	#unpack and apply the lm_sensors patch
	echo "Unpacking and applying lm_sensors patch..."
	cd ${S}/extras
	unpack lm_sensors-${SENV}.tar.gz
	cd lm_sensors-${SENV}
	mkpatch/mkpatch.pl . ${S} > ${S}/lm_sensors-patch
	rmdir src
	ln -s ../.. src
	cp -a Makefile Makefile.orig
	sed -e "s:^LINUX=.*:LINUX=src:" \
	    -e "s/^COMPILE_KERNEL.*/COMPILE_CERNEL := 0/" \
	    -e "s:^I2C_HEADERS.*:I2C_HEADERS=src/include:" \
	    -e "s#^DESTDIR.*#DESTDIR := ${D}#" \
	    -e "s#^PREFIX.*#PREFIX := /usr#" \
	    -e "s#^MANDIR.*#MANDIR := /usr/share/man#" \
	    Makefile.orig > Makefile
	cd ${S}
	patch -p1 < lm_sensors-patch
    fi
    
    #get sources ready for compilation or for sitting at /usr/src/linux
    echo "Preparing for compilation..."
    cd ${S}
    #sometimes we have icky kernel symbols; this seems to get rid of them
    try make mrproper
    if [ "${PN}" = "linux" ] || [ "${PN}" = "linux-extras" ]
    then
	#this is the configuration for the default kernel
	try cp ${FILESDIR}/${PVR}/config.bootcomp .config
	try yes \"\" \| make oldconfig
	echo '(Ignore any errors from the yes command above.)'
	try make include/linux/version.h
    fi
    #fix silly permissions in tarball
    cd ${WORKDIR}
    chown -R 0.0 ${S}
    chmod -R a+r-w+X,u+w ${S}
}

src_compile() {
    
    if [ "${PN}" = "linux" ] || [ "${PN}" = "linux-extras" ]
    then
	try make symlinks
	
	if [ "`use lvm`" ]
	then
	    #LVM tools are included in the linux and linux-extras pakcages
	    cd ${S}/extras/LVM/${LVMV}
	    
	    # I had to hack this in so that LVM will look in the current linux
	    # source directory instead of /usr/src/linux for stuff - pete
	    try CFLAGS=\""${CFLAGS} -I${S}/include"\" ./configure --prefix=/ --mandir=/usr/share/man --with-kernel_dir="${S}"
	    
	    try make
	fi
	
	if [ "`use lm_sensors`" ]
	then
	    cd ${S}/extras/lm_sensors-${SENV}
	    try make
	fi
	
	if [ "`use alsa`" ]
	then
	    cd ${S}/extras/alsa-driver-${AV}
	    try ./configure --with-kernel=\"${S}\" --with-isapnp=yes --with-sequencer=yes --with-oss=yes --with-cards=all
	fi
	
	cd ${S}
	
	if [ "$PN" == "linux" ]
	then
	    try make HOSTCFLAGS=\""${LINUX_HOSTCFLAGS}"\" dep
	    try make HOSTCFLAGS=\""${LINUX_HOSTCFLAGS}"\" LEX=\""flex -l"\" bzImage
	    try make HOSTCFLAGS=\""${LINUX_HOSTCFLAGS}"\" LEX=\""flex -l"\" modules
	    
	    if [ "`use alsa`" ]
	    then
		try make
	    fi
	fi
    fi
}

src_install() {
    if [ "${PN}" = "linux" ] || [ "${PN}" = "linux-extras" ]
    then
	dodir /usr/lib
	
	if [ "`use lvm`" ]
	then
	    cd ${S}/extras/LVM/${LVMV}/tools
	    
	    try CFLAGS=\"${CFLAGS} -I${S}/include\" make install -e prefix=${D} mandir=${D}/usr/share/man \
		sbindir=${D}/sbin libdir=${D}/lib
	    #no need for a static library in /lib
	    mv ${D}/lib/*.a ${D}/usr/lib
	fi
	
	if [ "`use lm_sensors`" ]
	then
	    #install sensors tools
	    cd ${S}/extras/lm_sensors-${SENV}
	    make install
	fi
	
	if [ "$(use alsa)" ]
	then
	    #install ALSA progs
	    cd ${S}/extras/alsa-driver-${AV}
	    into /usr
	    dosbin snddevices
	fi
	
	if [ "$PN" = "linux" ]
	then
	    dodir /usr/src
    	    
 	    if [ "`use alsa`" ]
            then
  	        #install ALSA modules
 	        cd ${S}/extras/alsa-driver-${AV}
	        dodir /lib/modules/${KV}/misc
	        cp modules/*.o ${D}/lib/modules/${KV}/misc
	
            fi
	    
	    dodir /usr/src/linux-${KV}
	    cd ${D}/usr/src
	    #grab includes and documentation only
#	    dodir /usr/src/linux-${KV}/include/linux
#	    dodir /usr/src/linux-${KV}/include/asm-i386
	    cp -ax ${S}/include ${D}/usr/src/linux-${KV}
	    cp -ax ${S}/Documentation ${D}/usr/src/linux-${KV}
#	    dodir /usr/include
#	    dosym ../src/linux/include/linux /usr/include/linux
#	    dosym ../src/linux/include/asm-i386 /usr/include/asm
	    
	    if [ "`use alsa`" ]
	    then
		# get alsa includes
		cd ${S}/extras/alsa-driver-${AV}
		insinto /usr/src/linux-${KV}/include/linux
		cd include
		doins asound.h asoundid.h asequencer.h ainstr_*.h
	    fi
	    
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
#	    rm -r ${D}/lib/modules/`uname -r`		
	    
	    depmod -b ${D} -F ${S}/System.map ${KV}
	    
	    #fix symlink
	    cd ${D}/lib/modules/${KV}
	    rm build
	    ln -sf /usr/src/linux-${KV} build
	fi
    elif [ "${PN}" = "linux-sources" ]
    then
	dodir /usr/src
    	
	cd ${S}
	make mrproper

	if [ "`use lvm`" ]
	then
	    cd ${S}/extras/LVM/${LVMV}
	    make distclean
	fi
	
	if [ "`use lm_sensors`" ]
	then
	    cd ${S}/extras/lm_sensors-${SENV}
	    make clean
	fi
	
	if [ "`use alsa`" ]
	then
	    # get alsa includes
	    cd ${S}/extras/alsa-driver-${AV}
	    insinto /usr/src/linux-${KV}/include/linux
	    cd include
	    doins asound.h asoundid.h asequencer.h ainstr_*.h
	    cd ${S}/extras/alsa-driver-${AV}
	    make distclean
	fi
	
	cp -ax ${S} ${D}/usr/src
    fi
}

pkg_postinst() {
    if [  "${ROOT}" = "/" ]
    then
	if [ "`use alsa`"  ] ; then
	    echo "Creating sounddevices..."
	    /usr/sbin/snddevices
		#needs to get fixed for devfs
	fi
    fi
    rm -f ${ROOT}/usr/src/linux
    ln -sf linux-${KV} ${ROOT}/usr/src/linux
}

pkg_postrm() {
    rm -f ${ROOT}/usr/src/linux
    rm -rf ${ROOT}/usr/src/linux-${KV}
}
