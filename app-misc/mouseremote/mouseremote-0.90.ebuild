# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/mouseremote/mouseremote-0.90.ebuild,v 1.2 2002/07/11 06:30:16 drobbins Exp $

DESCRIPTION="X10 MouseRemote"
HOMEPAGE="http://www4.pair.com/gribnif/ha/"
LICENSE="GPL-2"

SRC_URI="http://www4.pair.com/gribnif/ha/MouseRemote.tar.gz"

DEPEND=""
RDEPEND="dev-perl/Time-HiRes"

S=${WORKDIR}/MouseRemote

src_compile() {
	patch -p1 < ${FILESDIR}/${PN}-gentoo.diff || die
	cd MultiMouse && emake \
		PREFIX=/usr \
		LOCKDIR=/var/lock \
	    JMANDIR=/usr/share/man/ja_JP.ujis || die
}

src_install () {
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
