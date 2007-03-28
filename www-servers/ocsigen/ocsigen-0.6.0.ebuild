# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/ocsigen/ocsigen-0.6.0.ebuild,v 1.1 2007/03/28 17:20:45 aballier Exp $

inherit eutils findlib multilib

DESCRIPTION="Ocaml-powered webserver and framework for dynamic web programming"
HOMEPAGE="http://www.ocsigen.org"
SRC_URI="http://www.ocsigen.org/download/ocsigen-0.6.0.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug ocamlduce"
RESTRICT="nostrip"

DEPEND="dev-ml/findlib
		>=dev-lang/ocaml-3.08.4
		>=dev-ml/ocamlnet-2.2
		>=dev-ml/ocaml-ssl-0.4
		ocamlduce? ( dev-ml/ocamlduce )"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup ocsigen
	enewuser ocsigen -1 -1 /var/www ocsigen
}

src_compile() {
	./configure \
		--prefix "${D}" \
		--bindir /usr/bin \
		--docdir /usr/share/doc \
		--mandir /usr/share/man/man1 \
		--libdir /usr/$(get_libdir) \
		$(use_enable debug) \
		$(use_enable ocamlduce) \
		--ocsigen-group ocsigen \
		--ocsigen-user ocsigen  \
		--name ocsigen \
		|| die "Error : configure failed!"
	emake -j1 depend
	emake -j1 || die "Error : make failed!"
}

src_install() {
	emake -j1 fullinstall
	newinitd "${FILESDIR}"/ocsigen.initd ocsigen || die
	newconfd "${FILESDIR}"/ocsigen.confd ocsigen || die
}

