# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/gitolite/gitolite-1.5.9.1.ebuild,v 1.4 2011/05/31 17:24:02 phajdan.jr Exp $

EAPI=3

inherit eutils perl-module

DESCRIPTION="Highly flexible server for git directory version tracker"
HOMEPAGE="http://github.com/sitaramc/gitolite"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="contrib vim-syntax"

DEPEND="dev-lang/perl
	>=dev-vcs/git-1.6.2"
RDEPEND="${DEPEND}
	!dev-vcs/gitolite-gentoo
	vim-syntax? ( app-vim/gitolite-syntax )"

pkg_setup() {
	enewgroup git
	enewuser git -1 /bin/bash /var/lib/gitolite git
}

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}"/sitaramc-"${PN}"-* "${S}" || die
}

src_prepare() {
	rm Makefile doc/COPYING contrib/autotoc
	rm -rf contrib/{gitweb,vim}
}

src_install() {
	dodir /usr/share/gitolite/{conf,hooks} /usr/bin || die
	echo "${PF}" > conf/VERSION

	# install using upstream method
	./src/gl-system-install "${D}"/usr/bin \
		"${D}"/usr/share/gitolite/conf "${D}"/usr/share/gitolite/hooks || die
	sed -i -e "s:${D}::g" "${D}/usr/bin/gl-setup" \
		"${D}/usr/share/gitolite/conf/example.gitolite.rc" || die

	rm "${D}"/usr/bin/gitolite.pm
	insinto "${VENDOR_LIB}"
	doins src/gitolite.pm || die

	dodoc README.mkd doc/*

	if use contrib; then
		insinto /usr/share/doc/${PF}
		doins -r contrib || die
	fi

	keepdir /var/lib/gitolite
	fowners git:git /var/lib/gitolite
	fperms 750 /var/lib/gitolite
}

pkg_postinst() {
	# bug 352291
	ewarn
	elog "Please make sure that your 'git' user has the correct homedir (/var/lib/gitolite)."
	elog "Especially if you're migrating from gitosis."
	ewarn
}
