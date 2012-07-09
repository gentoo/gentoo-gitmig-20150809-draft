# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/lwt/lwt-2.3.2.ebuild,v 1.3 2012/07/09 20:55:40 ulm Exp $

EAPI=3

inherit oasis

MY_P=${P/_/+}
DESCRIPTION="Cooperative light-weight thread library for OCaml"
SRC_URI="http://ocsigen.org/download/${MY_P}.tar.gz"
HOMEPAGE="http://ocsigen.org/lwt"

IUSE="gtk +react +ssl"

DEPEND="react? ( dev-ml/react )
	dev-libs/libev
	ssl? ( >=dev-ml/ocaml-ssl-0.4.0 )
	gtk? ( dev-ml/lablgtk dev-libs/glib:2 )"

RDEPEND="${DEPEND}
	!<www-servers/ocsigen-1.1"

SLOT="0"
LICENSE="LGPL-2.1-with-linking-exception"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"

S=${WORKDIR}/${MY_P}

DOCS=( "CHANGES" "CHANGES.darcs" "README" )

src_configure() {
	oasis_configure_opts="$(use_enable gtk glib)
		$(use_enable react)
		$(use_enable ssl)" \
		oasis_src_configure
}
