# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/win4lin/win4lin-4.0.11.ebuild,v 1.2 2002/12/16 10:44:09 yakmoose Exp $

IUSE="X gnome"

MY_P=Win4Lin-5.3.11a-d.i386
S=${WORKDIR}
DESCRIPTION="Win4Lin allows you run Windows applications somewhat natively
under linux."
HOMEPAGE="http://www.netraverse.com/"
At="Win4Lin-5.3.11a-d.i386.rpm"
SRC_URI=""

SLOT="0"
LICENSE="NeTraverse"
KEYWORDS=""

DEPEND="app-arch/rpm2targz"

RESTRICT="nofetch"


# The rpm for this can be downloaded from www.netraverse.com after you
# register there.  Please place Win4Lin-5.3.11a-d.i386.rpm into
# /usr/portage/distfiles after downloading, then emerge win4lin again

src_unpack() {
	#check for the dist file
       if [ ! -f ${DISTDIR}/${At} ] ; then
                die "Please download ${At} from ${HOMEPAGE} and place in /usr/portage/distfiles"
        fi 
	rpm2targz ${DISTDIR}/${MY_P}.rpm
	tar zxf ${WORKDIR}/${MY_P}.tar.gz
}

src_compile() {
	echo "nothing to compile; binary package."
}

src_install() {
	mv ${S}/opt ${D}
	mv ${S}/etc ${D}
}

pkg_postinst() {
	/opt/win4lin/postinst_rpm.sh
	einfo ">>> If this is a new Win4Lin Install you will need to run the following command"
        einfo ">>> ebuild  /var/db/pkg/app-emulation/${PF}/${PF}.ebuild config"
        einfo ">>> to install the windows setup files. You will need your Windows cdrom in the "
	einfo ">>> drive in order to complete this step."
}


pkg_prerm() {
	/opt/win4lin/remove_rpm.sh
}

pkg_config() {
	loadwindowsCD cddevice /dev/cdrom
	#put debugging stuff here
	if [ ${?} -eq "0" ]; then
		einfo ">>> You can now run the command \"installwindows\" from an xterm "
		einfo ">>> as a non-root user to install a personal copy of Windows that Win4Lin "
		einfo ">>> will use for that user."
	fi
}