# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/mythtv/mythtv-0.11.ebuild,v 1.4 2004/01/15 18:03:59 max Exp $

inherit flag-o-matic

DESCRIPTION="Homebrew PVR project."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="lcd"

DEPEND="virtual/x11
	>=x11-libs/qt-3
	>=media-tv/xmltv-0.5.16
	>=media-sound/lame-3.93.1
	>=media-libs/freetype-2.0
	>=sys-apps/sed-4
	lcd? ( app-misc/lcdproc )"

RDEPEND="${DEPEND}
	!media-tv/mythfrontend"

src_unpack() {
	unpack ${A}

	for i in `grep -lr usr/local "${S}"` ; do
		sed -e "s:usr/local:usr:" -i "${i}" || die "sed failed"
	done
}

src_compile() {
	cpu="`get-flag march`"
	if [ -n "${cpu}" ] ; then
		sed -e "s:pentiumpro:${cpu}:g" -i "${S}/settings.pro" || die "sed failed"
	fi

	qmake -o "${S}/Makefile" "${S}/${PN}.pro"

	econf "`use_enable lcd`"
	make || die "compile problem"
}

src_install() {
	einstall INSTALL_ROOT="${D}"
	newbin "setup/setup" "mythsetup"

	dodir /etc/mythtv
	mv "${D}/usr/share/mythtv/mysql.txt" "${D}/etc/mythtv"
	dosym /etc/mythtv/mysql.txt /usr/share/mythtv/mysql.txt

	exeinto /etc/init.d
	newexe "${FILESDIR}/mythbackend.rc6" mythbackend

	insinto /etc/conf.d
	newins "${FILESDIR}/mythbackend.conf" mythbackend

	exeinto /usr/share/mythtv
	doexe "${FILESDIR}/mythfilldatabase.cron"

	insinto /usr/share/mythtv/database
	doins "${S}"/database/*

	dodoc AUTHORS COPYING FAQ README UPGRADING keys.txt docs/*.txt
	dohtml docs/*.html

	keepdir /var/{log,run}/mythtv
}

pkg_postinst() {
	ewarn "Please note that /usr/share/mythtv/setup has been moved"
	ewarn "to /usr/bin/mythsetup"
	echo

	einfo "If this is the first time you install MythTV,"
	einfo "you need to add /usr/share/mythtv/database/mc.sql"
	einfo "to your mysql database."
	einfo
	einfo "You might run 'mysql < /usr/share/mythtv/database/mc.sql'"
	einfo
	einfo "Next, you need to run the mythsetup program."
	einfo "It will ask you some questions about your hardware, and"
	einfo "then run xmltv's grabber to configure your channels."
	einfo
	einfo "Once you have configured your database, you can run"
	einfo "/usr/bin/mythfilldatabase to populate the schedule"
	einfo "or copy /usr/share/mythtv/mythfilldatabase.cron to"
	einfo "/etc/cron.daily for this to happen automatically."
	einfo
	einfo "If you're upgrading from an older version and for more"
	einfo "setup and usage instructions, please refer to:"
	einfo "   /usr/share/doc/${PF}/README.gz"
	einfo "   /usr/share/doc/${PF}/UPGRADING.gz"
	ewarn "This part is important as there might be database changes"
	ewarn "which need to be performed or this package will not work"
	ewarn "properly."
	echo
}
