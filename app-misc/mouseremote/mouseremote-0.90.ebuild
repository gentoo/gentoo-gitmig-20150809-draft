# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mouseremote/mouseremote-0.90.ebuild,v 1.16 2007/01/28 05:20:58 genone Exp $

inherit eutils

S="${WORKDIR}/MouseRemote"
DESCRIPTION="X10 MouseRemote"
HOMEPAGE="http://www4.pair.com/gribnif/ha/"
SRC_URI="http://www4.pair.com/gribnif/ha/MouseRemote.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND="virtual/perl-Time-HiRes"

src_compile() {
	epatch ${FILESDIR}/${PN}-gentoo.diff
	cd MultiMouse && emake \
		PREFIX=/usr \
		LOCKDIR=/var/lock \
	    JMANDIR=/usr/share/man/ja_JP.ujis || die
}

src_install() {
	dobin MultiMouse/multimouse
	dosbin MultiMouse/multimoused

	dodoc README MultiMouse/README.jis MultiMouse/README.newstuff
	newdoc MultiMouse/README README.MultiMouse
	newdoc client/MouseRemote.conf MouseRemote.conf.dist
	newdoc client/MouseRemote.pl MouseRemote.pl.dist
	newdoc client/MouseRemoteKeys.pl MouseRemoteKeys.pl.dist

	exeinto /etc/init.d
	newexe ${FILESDIR}/mouseremote.start mouseremote
	insinto /etc/conf.d
	newins ${FILESDIR}/mouseremote.conf mouseremote
}

pkg_postinst() {
	[ -e /dev/mumse ] || mkfifo ${ROOT}/dev/mumse
	[ -e /dev/x10fifo ] || mkfifo ${ROOT}/dev/x10fifo

	elog "To use the mouse function in X, add the following to your XF86Config"
	elog "Section \"InputDevice\""
	elog "	Identifier  \"MouseREM\""
	elog "	Driver      \"mouse\""
	elog "	Option      \"Protocol\"      \"MouseSystems\""
	elog "	Option      \"Device\"        \"/dev/mumse\""
	elog "EndSection"
	elog
	elog "Don't forget to add the new device to the section \"ServerLayout\""
	elog "like:	InputDevice \"MouseREM\" \"SendCoreEvents\""
	elog
	elog "Enable the daemon with \"rc-update add mouseremote default\"."
	elog
	elog "Configure the daemon is run in /etc/conf.d/mouseremote."
	elog
	elog "See /usr/share/doc/${PF} on how to configure the buttons."
}
