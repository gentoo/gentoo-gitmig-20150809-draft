# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/win4lin/win4lin-5.0.4.ebuild,v 1.6 2004/02/20 06:08:34 mr_bones_ Exp $

IUSE="doc"

MY_P=Win4Lin-5.5.4d-d.i386

S=${WORKDIR}
DESCRIPTION="Win4Lin allows you run Windows applications somewhat natively
under linux."
HOMEPAGE="http://www.netraverse.com/"
SRC_URI="mirror://gentoo/${MY_P}.rpm"
#    doc? ( https://www.netraverse.com/support/docs/Win4Lin-4.0.0-manual.pdf )"

SLOT="0"
LICENSE="NeTraverse"
KEYWORDS="x86"

DEPEND="app-arch/rpm2targz
		virtual/winkernel"
RDEPEND="!<=app-emulation/win4lin-4.0.22"

src_unpack() {
	rpm2targz ${DISTDIR}/${MY_P}.rpm
	tar zxf ${WORKDIR}/${MY_P}.tar.gz
}

src_compile() {
	einfo "nothing to compile; binary package."
	einfo "Remember you need a kernel patched like"
	einfo "win4lin-sources or gs-sources."
}

src_install() {
	mv ${S}/opt ${D}
	mv ${S}/etc ${D}
	cp ${FILESDIR}/registerme.sh ${D}/opt/win4lin/
	cp ${FILESDIR}/win4lin.initd.new ${D}/opt/win4lin/

#    if [ -n "`use doc`" ]
#    then
#        dodoc ${DISTDIR}/Win4Lin-4.0.0-manual.pdf
#    fi
}


pkg_postinst() {
	/opt/win4lin/postinst_rpm.sh
	echo "LICENSE_CODE=1w5e055x-n0ca34-xjhx-xx3c-4c3c-73" > /var/win4lin/install/license.lic
	einfo "If this is a new Win4Lin Install you will need to run the following command"
	einfo "ebuild  /var/db/pkg/app-emulation/${PF}/${PF}.ebuild config"
	einfo "to install the windows setup files. You will need your Windows cdrom in the "
	einfo "drive in order to complete this step."
	einfo "============"
	einfo "If this is an upgrade 4.x to 5.x the trial license code isn't valid,"
	einfo "you need register it in NeTraverse, or unemerge ALL Win4Lin files."
}


pkg_prerm() {
	/opt/win4lin/remove_rpm.sh
}

pkg_config() {
	loadwindowsCD cddevice /dev/cdrom
	cp /opt/win4lin/win4lin.initd.new /etc/init.d/Win4Lin
	chmod +x /etc/init.d/Win4Lin

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
