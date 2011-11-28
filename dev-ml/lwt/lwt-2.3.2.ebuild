# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/lwt/lwt-2.3.2.ebuild,v 1.1 2011/11/28 13:10:32 aballier Exp $

EAPI=2

inherit findlib eutils multilib

MY_P=${P/_/+}
DESCRIPTION="Cooperative light-weight thread library for OCaml"
SRC_URI="http://ocsigen.org/download/${MY_P}.tar.gz"
HOMEPAGE="http://ocsigen.org/lwt"

IUSE="gtk +ocamlopt +react +ssl"

DEPEND=">=dev-lang/ocaml-3.12[ocamlopt?]
	react? ( dev-ml/react )
	dev-libs/libev
	ssl? ( >=dev-ml/ocaml-ssl-0.4.0 )
	gtk? ( dev-ml/lablgtk dev-libs/glib:2 )"

RDEPEND="${DEPEND}
	!<www-servers/ocsigen-1.1"

SLOT="0"
LICENSE="LGPL-2.1 LGPL-2.1-linking-exception"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"

S=${WORKDIR}/${MY_P}

oasis_use_enable() {
	echo "--override $2 `use $1 && echo \"true\" || echo \"false\"`"
}

src_configure() {
	./configure --prefix usr \
		--libdir /usr/$(get_libdir) \
		--docdir /usr/share/doc/${PF}/html \
		--destdir "${D}" \
		$(use_enable gtk glib) \
		$(use_enable react) \
		$(use_enable ssl) \
		$(oasis_use_enable ocamlopt is_native) \
		|| die
}

src_install() {
	findlib_src_install
	dodoc CHANGES* README || die
}
