# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/ocsigen/ocsigen-0.99.2.ebuild,v 1.2 2007/09/01 01:57:34 mr_bones_ Exp $

inherit eutils findlib multilib

DESCRIPTION="Ocaml-powered webserver and framework for dynamic web programming"
HOMEPAGE="http://www.ocsigen.org"
SRC_URI="http://www.ocsigen.org/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug ocamlduce doc logrotate dbm sqlite"
RESTRICT="strip"

DEPEND="dev-ml/findlib
		>=dev-lang/ocaml-3.08.4
		>=dev-ml/ocamlnet-2.2
		>=dev-ml/ocaml-ssl-0.4
		ocamlduce? ( dev-ml/ocamlduce )
		!dbm? ( dev-ml/ocaml-sqlite3 )
		sqlite? ( dev-ml/ocaml-sqlite3 )"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup ocsigen
	enewuser ocsigen -1 -1 /var/www ocsigen

	use !dbm && use !sqlite \
		&& ewarn "Neither dbm nor sqlite are in useflags, will enable sqlite as default"

	use sqlite && use dbm \
		&& ewarn "sqlite and dbm are both in useflags, will use only sqlite"

	if use !sqlite && use dbm && ! built_with_use dev-lang/ocaml gdbm; then
		eerror "You need to compile dev-lang/ocaml with gdbm support"
		eerror "in order to use ${PN} with dbm"
		die "please reinstall dev-lang/ocaml with gdbm support"
	fi
}

use_enable_default() {
	if use $2; then
		if use $1; then
			echo "--enable-$2  --enable-$1"
		else
			echo "--enable-$2  --disable-$1"
		fi
	else
		echo "--disable-$2  --enable-$1"
	fi
}

src_compile() {
	./configure \
		--temproot "${D}" \
		--bindir /usr/bin \
		--docdir /usr/share/doc \
		--mandir /usr/share/man/man1 \
		--libdir /usr/$(get_libdir) \
		$(use_enable debug) \
		$(use_enable ocamlduce) \
		$(use_enable_default sqlite dbm) \
		--ocsigen-group ocsigen \
		--ocsigen-user ocsigen  \
		--name ocsigen \
		|| die "Error : configure failed!"
	emake -j1 depend || die "Error : make depend failed!"
	emake -j1 || die "Error : make failed!"
}

src_install() {
	if use doc ; then
		emake -j1 install || die "Error : make install failed!"
	else
		emake -j1 installnodoc || die "Error : make install failed!"
	fi

	if use logrotate ; then
		emake -j1 logrotate || die "Error : make logrotate failed!"
	fi

	newinitd "${FILESDIR}"/ocsigen.initd ocsigen || die
	newconfd "${FILESDIR}"/ocsigen.confd ocsigen || die

	dodoc README
}
