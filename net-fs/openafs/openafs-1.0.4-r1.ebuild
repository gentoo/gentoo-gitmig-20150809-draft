# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Holger Brueckner <darks@fet.org>

S=${WORKDIR}/${P}
DESCRIPTION="The AFS 3 distributed file system  targets the issues  critical to
distributed computing environments. AFS performs exceptionally well,
both within small, local work groups of machines and across wide-area
configurations in support of large, collaborative efforts. AFS provides
an architecture geared towards system management, along with the tools
to perform important management tasks. For a user, AFS is a familiar yet
extensive UNIX environment for accessing files easily and quickly."

SRC_URI="http://www.openafs.org/dl/openafs/1.0.4/openafs-1.0.4-src.tar.bz2"
HOMEPAGE="http://www.openafs.org/"

DEPEND="virtual/glibc
        >=sys-libs/ncurses-5.2
	>=sys-libs/pam-0.75"


src_compile() {

    export KERNELVERSION=`grep "UTS_RELEASE" /usr/src/linux/include/linux/version.h | awk '{print $3}' | sed "s/\"//g"`
    KERNELSHORT=`echo $KERNELVERSION | cut -c1-3 | sed "s/\.//"`
    SYSTEM="linux"
    SYSARCH="i386"
    CELLNAME=`cat ${FILESDIR}/ThisCell`

    try mkdir ${SYSARCH}_${SYSTEM}${KERNELSHORT}
    try mkdir ${SYSARCH}_${SYSTEM}${KERNELSHORT}/dest
    try mkdir ${SYSARCH}_${SYSTEM}${KERNELSHORT}/obj
    ln -s "@sys/dest" dest
    ln -s "@sys/obj" obj
    ln -s ${SYSARCH}_${SYSTEM}${KERNELSHORT} @sys
    ln -s src/Makefile Makefile
    try make links
    try make SYS_NAME="${SYSARCH}_${SYSTEM}${KERNELSHORT}" \
	LINUX_VERS="${KERNELVERSION}" TXLIBS=/lib/libncurses.so \
	OPTMZ="$CFLAGS" XCFLAGS="$CFLAGS" \
	PAM_CFLAGS="$CFLAGS -Dlinux -DLINUX_PAM -fPIC"
}

src_install () {


  # Client

  cd ${S}/dest/root.client/usr/vice

  insinto /etc/afs/modload
  doins etc/modload/*
  insinto /etc/afs/C
  doins etc/C/*

  insinto /etc/afs
  doins ${FILESDIR}/{ThisCell,CellServDB}
  doins etc/afs.conf

  dodir /afs

  exeinto /etc/rc.d/init.d
  newexe ${FILESDIR}/afs.rc afs

  dosbin etc/afsd

  # Client Bin
  cd ${S}/dest
  exeinto /usr/afsws/bin
  doexe bin/*

  exeinto /etc/afs/afsws
  doexe etc/*

  cp -a include lib ${D}/usr/afsws
  dosym  /usr/afsws/lib/afs/libtermlib.a /usr/afsws/lib/afs/libnull.a

  # Server
  cd ${S}/dest/root.server/usr/afs
  exeinto /usr/afs/bin
  doexe bin/*

  dodir /usr/vice
  dosym /etc/afs /usr/vice/etc
  dosym /etc/afs/afsws /usr/afsws/etc

  dodoc ${FILESDIR}/README
}

pkg_postinst () {
    if [ "$PN" = "openafs_client" ]
    then
      echo ">>> UPDATE CellServDB and ThisCell to your needs !!"
    elif [ "$PN" = "openafs_client_bin" ]
    then
      echo ">>> UPDATE CellServDB and ThisCell to your needs !!"
    else
      echo ">>> FOLLOW THE INSTRUCTIONS IN AFS QUICK BEGINNINGS"
      echo ">>> PAGE >45 TO DO INITIAL SERVER SETUP"
    fi
}
