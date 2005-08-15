# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/win4lin/win4lin-4.0.16.ebuild,v 1.9 2005/08/15 16:51:48 plasmaroo Exp $

IUSE="doc"

MY_P=Win4Lin-5.3.16a-d.i386

S=${WORKDIR}
DESCRIPTION="Win4Lin allows you run Windows applications somewhat natively
under linux."
HOMEPAGE="http://www.netraverse.com/"
SRC_URI="mirror://gentoo/${MY_P}.rpm
	doc? ( https://www.netraverse.com/support/docs/Win4Lin-4.0.0-manual.pdf )"

SLOT="0"
LICENSE="NeTraverse"
KEYWORDS="-* x86"

DEPEND="app-arch/rpm2targz"

src_unpack() {
	rpm2targz ${DISTDIR}/${MY_P}.rpm
	tar zxf ${WORKDIR}/${MY_P}.tar.gz
}

src_compile() {
	einfo "nothing to compile; binary package."
}

src_install() {
	mv ${S}/opt ${D}
	mv ${S}/etc ${D}
	cp ${FILESDIR}/registerme.sh ${D}/opt/win4lin/

	if use doc
	then
		dodoc ${DISTDIR}/Win4Lin-4.0.0-manual.pdf
	fi
}


pkg_postinst() {
	/opt/win4lin/postinst_rpm.sh
	einfo "If this is a new Win4Lin Install you will need to run the following command"
	einfo "ebuild  /var/db/pkg/app-emulation/${PF}/${PF}.ebuild config"
	einfo "to install the windows setup files. You will need your Windows cdrom in the "
	einfo "drive in order to complete this step."
}


pkg_prerm() {
	/opt/win4lin/remove_rpm.sh
}

pkg_config() {
	loadwindowsCD cddevice /dev/cdrom
	echo "LICENSE_CODE=1w4e053x-n0aaf8-7tw9-587j-h47j-d6" > /var/win4lin/install/license.lic
	ln -s /etc/rc.d/init.d/Win4Lin /etc/init.d/Win4Lin
	#put debugging stuff here
	if [ ${?} -eq "0" ]; then
		einfo "You can now run the command \"installwindows\" from an xterm "
		einfo "as a non-root user to install a personal copy of Windows that Win4Lin "
		einfo "will use for that user."
		einfo
		einfo "Win4Lin is a commercial product, you now are using a evaluation-license"
		einfo "for 15 days evaluation. If you want a extra 15 days of evaluation you"
		einfo 'must run "sh /opt/win4lin/registerme.sh"'
		einfo
		einfo 'You can help Gentoo Linux and obatin a full license at a discont offer'
		einfo 'for gentoo users in http://www.netraverse.com/gentoo.htm'
		einfo 'Netraverse donate to Gentoo Linux a percent of each purchase.'
		einfo 'Thanks Netraverse.'
		einfo
		einfo 'Remember, you must do "/etc/init.d/Win4Lin start" before start w4l'
		einfo 'Also you can add it to default boot "rc-update add Win4Lin default"'
	fi
}
