# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/ctcs/ctcs-1.3.0_pre4.ebuild,v 1.1 2002/08/27 00:33:31 gaarde Exp $

# Author:  Paul Belt <gaarde at gentoo dot org>

# ${A}        - the tarball itself             eg:  ${PORTDIR}/distfiles/t.tgz
# ${P}        - program name-program version   eg:  foo-1.0
# ${PN}       - program name                   eg:  foo
# ${PV}       - program version                eg:  1.0
# ${D}        - /var/tmp/portage/foo-1.0/image -- install files go here
# ${S}        - /var/tmp/portage/foo-1.0/work/${P}
# ${WORKDIR}  - /var/tmp/portage/foo-1.0/work
# ${FILESDIR} - Location of patches

MY_P="ctcs-1.3.0pre4"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="CTCS (Cerberus Test Control System) used to make sure that new systems are ready to go out and face the perils of the cold, hard world.  It's made up of a suite of programs that literally pound the system.  The tests are meant for hardware with nothing on it yet... you will lose data.  Not might.  Will.  Please read at least README.FIRST before attempting to use the Cerberus Test Control System as certain configurations of CTCS may damage your system."

# Developer reference
HOMEPAGE="http://sourceforge.net/projects/va-ctcs"

# ftp:// and http ://are known to work
# file:// is known to not work
#
# If the file is local on the HD, just leave it blank
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/va-ctcs/${MY_P}.tar.gz"

# See ${PORTDIR}/licenses ... pick one of the file names
LICENSE="GPL-2"

# Multiple versions use version number
# SLOT='2.4.19'
#
# Default
# SLOT='0'
SLOT="0"

# KEYWORDS='x86 ppc sparc sparc64'
KEYWORDS="x86"

# Runtime dependancies
RDEPEND="virtual/glibc
		 dev-util/dialog
		 sys-apps/bash
		 sys-apps/diffutils
		 sys-apps/e2fsprogs
		 sys-apps/fileutils
		 sys-apps/grep
		 sys-apps/modutils
		 sys-apps/psmisc
		 sys-apps/sed
		 sys-apps/sh-utils
		 sys-apps/textutils
		 sys-apps/util-linux
		 sys-devel/make
		 sys-devel/perl
		 sys-libs/ncurses"

# Optional: app-admin/smartsuite  (depricated?)
# Optional: sys-apps/lm_sensors

# Needed for compiling
DEPEND="${RDEPEND}"

src_compile() {
   # ./configure \
   # --host=${CHOST} \
   # --prefix=/usr \
   # --infodir=/usr/share/info \
   # --mandir=/usr/share/man || die "./configure failed"
   #
   # make || die

#	econf || die
	emake || die
}

src_install () {
   # make DESTDIR=${D} install || die
   #
   # make \
   #	prefix=${D}/usr \
   #	mandir=${D}/usr/share/man \
   #	infodir=${D}/usr/share/info \
   #	install || die

   dodoc CHANGELOG FAQ README.FIRST COPYING README README.TCF runin/README.runtest runin/README.tests

   mkdir -p ${D}/usr/ctcs/runin/bin/

#   cp -R ${S}/runin ${D}/usr/ctcs/runin
   cp -Rap ${S}/lib ${D}/usr/ctcs/lib
   cp -Rap ${S}/selftest ${D}/usr/ctcs/selftest
   cp -Rap ${S}/sample ${D}/usr/ctcs/sample

   # The 'binaries'
   cp -ap ${S}/burnreset ${S}/check-requirements ${S}/check-syntax ${S}/color \
      ${S}/newburn ${S}/newburn-generator ${S}/report ${S}/run ${D}/usr/ctcs/

   cp -ap ${S}/runin/src/random ${S}/runin/src/prandom ${D}/usr/ctcs/runin/bin/
   cp -ap ${S}/runin/src/flushb ${D}/usr/ctcs/runin/bin/flushb.real
   cp -ap ${S}/runin/src/chartst ${S}/runin/src/memtst.src/memtst \
          ${D}/usr/ctcs/runin/

   for f in burnBX burnMMX burnP5 burnP6 burnK6 burnK7; do
      cp ${S}/runin/src/cpuburn/${f} ${D}/usr/ctcs/runin/bin/
   done

#   einstall || die
   # into   -- sets prefix for
   # dobin
   # dolib
   # dolib.a
   # dolib.so
   # doman
   # dosbin
   # doinfo
   # dosym
   # dosed
   # Again, verify the Makefiles!  We don't want anything falling
   # outside of ${D}.
}

src_postinst() {
   cd /usr/ctcs/runin
   dosym messages-info allmessages-info
   dosym blockrdtst sblockrdtst
   dosym blockrdtst-info sblockrdtst-info
   dosym data sdata
   dosym data-info sdata-info
   dosym destructiveblocktst sdestructiveblocktst
   dosym destructiveblocktst-info sdestructiveblocktst-info
   dosym traverseread-info straverseread-info
   dosym traverseread straverseread
}
