# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/dancer-ircd/dancer-ircd-1.0.35.ebuild,v 1.2 2005/07/31 20:41:03 swegener Exp $

inherit eutils

DESCRIPTION="The ircd used by the freenode network"
HOMEPAGE="http://freenode.net/dancer_ircd.shtml"
SRC_URI="http://source.freenode.net/~asuffield/dancer/dancer-ircd/stable/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~hppa ~ppc ~sparc x86"
IUSE="doc"

DEPEND="doc? (
		app-text/openjade
		dev-perl/SGMLSpm
		app-text/docbook-sgml-dtd
		app-text/docbook-sgml-utils
	)"

pkg_setup() {
	enewuser dancer
}

src_unpack() {
	unpack ${A}

	sed -i \
		-e s:etc/:/etc/: \
		-e s:var/:/var/: \
		"${S}"/src/paths.c
}

src_compile() {
	econf \
		--enable-optimise \
		--disable-errors \
		--disable-debug-syms \
		|| die "econf failed"
	emake || die "emake failed"

	if use doc
	then
		docbook2html -u doc/sgml/dancer-oper-guide/dancer-oper-guide.sgml
		docbook2html -u doc/sgml/dancer-user-guide/dancer-user-guide.sgml
	fi
}

src_install() {
	dobin src/dancer-ircd

	insinto /etc/dancer-ircd
	newins doc/example.conf ircd.conf

	newinitd "${FILESDIR}"/dancer-ircd-1.0.35 dancer-ircd
	newconfd "${FILESDIR}"/dancer-ircd.confd dancer-ircd

	keepdir /var/{lib,log,run}/dancer-ircd

	dodoc AUTHORS ChangeLog NEWS README doc/README.umodes doc/example.conf

	if use doc
	then
		dohtml dancer-oper-guide.html dancer-user-guide.html
	fi
}

pkg_postinst() {
	chown dancer "${ROOT}"/var/{lib,log,run}/dancer-ircd

	if ! use doc
	then
		einfo "If you need the dancer-oper-guide or the"
		einfo "dancer-user-guide, please reemerge with"
		einfo "USE=\"doc\" emerge dancer-ircd"
	fi
}
