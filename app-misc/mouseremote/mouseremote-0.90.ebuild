# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mouseremote/mouseremote-0.90.ebuild,v 1.9 2004/03/24 21:26:32 mr_bones_ Exp $

inherit eutils

S="${WORKDIR}/MouseRemote"
DESCRIPTION="X10 MouseRemote"
HOMEPAGE="http://www4.pair.com/gribnif/ha/"
SRC_URI="http://www4.pair.com/gribnif/ha/MouseRemote.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="dev-perl/Time-HiRes"

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

	einfo "To use the mouse function in X, add the following to your XF86Config"
	einfo "Section \"InputDevice\""
	einfo "	Identifier  \"MouseREM\""
	einfo "	Driver      \"mouse\""
	einfo "	Option      \"Protocol\"      \"MouseSystems\""
	einfo "	Option      \"Device\"        \"/dev/mumse\""
	einfo "EndSection"
	einfo
	einfo "Don't forget to add the new device to the section \"ServerLayout\""
	einfo "like:	InputDevice \"MouseREM\" \"SendCoreEvents\""
	einfo
	einfo "Enable the daemon with \"rc-update add mouseremote default\"."
	einfo
	einfo "Configure the daemon is run in /etc/conf.d/mouseremote."
	einfo
	einfo "See /usr/share/doc/${PF} on how to configure the buttons."
}
