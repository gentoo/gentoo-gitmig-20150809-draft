# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_keyring/pam_keyring-0.0.8.ebuild,v 1.1 2006/10/02 05:03:44 tester Exp $

inherit multilib eutils

DESCRIPTION="Unlock GNOME keyring with login password"
HOMEPAGE="http://www.hekanetworks.com/pam_keyring/"
SRC_URI="http://www.hekanetworks.com/opensource/pam_keyring/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-libs/pam
	>=gnome-base/gnome-session-2.10
	>=gnome-base/gnome-keyring-0.4.8"

src_unpack() {
	unpack ${A}

	epatch ${FILESDIR}/${P}-fixes.patch
}

src_compile() {
	econf --libdir=/$(get_libdir) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "install failed"
	rm -f ${D}/$(get_libdir)/security/*.{a,la}
	dodoc AUTHORS ChangeLog README TODO
	dodoc ${FILESDIR}/gdm.example
}

pkg_postinst() {
	einfo "There is a example of a /etc/pam.d/gdm with pam_keyring"
	einfo "at /usr/share/doc/${PF}/gdm.example.gz"
}
