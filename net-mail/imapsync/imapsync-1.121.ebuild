# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/imapsync/imapsync-1.121.ebuild,v 1.3 2005/07/07 13:56:02 ticho Exp $

inherit eutils

DESCRIPTION="A tool allowing incremental and recursive imap transfer from one mailbox to another."
HOMEPAGE="http://www.linux-france.org/prj/"
SRC_URI="http://www.linux-france.org/prj/imapsync/dist/${P}.tgz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86"
IUSE="ssl"

DEPEND=">=dev-perl/Mail-IMAPClient-2.1.4"

RDEPEND="${DEPEND}
	perl-core/Digest-MD5
	dev-perl/Digest-HMAC"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-gentoo.patch || \
		die "failed to patch ${P}-gentoo.patch"

	if use ssl; then
		echo $PWD
		cp imapsync imapsync-ssl
		epatch ${FILESDIR}/${PN}-ssl.patch || die "patch failed"
		epatch ${S}/patches/imapsync-ssl.diff || \
			die "failed to patch imapsync-ssl.diff"
	fi
}

src_install() {
	make install DESTDIR=${D} || die "make failed"
	#into /usr
	dobin imapsync imapsync-ssl
	rm ${D}/imapsync || die "failed to rm imapsync"

	dodoc CREDITS ChangeLog FAQ INSTALL README TODO || \
		die "dodoc failed"

}
