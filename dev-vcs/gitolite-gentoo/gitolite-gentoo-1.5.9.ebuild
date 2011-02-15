# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/gitolite-gentoo/gitolite-gentoo-1.5.9.ebuild,v 1.1 2011/02/15 17:08:39 idl0r Exp $

EAPI=3

inherit eutils perl-module

DESCRIPTION="Highly flexible server for git directory version tracker, Gentoo fork"
HOMEPAGE="http://git.overlays.gentoo.org/gitweb/?p=proj/gitolite-gentoo.git;a=summary"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="contrib vim-syntax"

DEPEND="dev-lang/perl
	>=dev-vcs/git-1.6.2"
RDEPEND="${DEPEND}
	!dev-vcs/gitolite
	dev-perl/Net-SSH-AuthorizedKeysFile
	vim-syntax? ( app-vim/gitolite-syntax )"

pkg_setup() {
	enewgroup git
	enewuser git -1 /bin/bash /var/lib/gitolite git
}

src_prepare() {
	rm -rf Makefile doc/COPYING contrib/{autotoc,gitweb,vim} || die

	echo "${PF}-gentoo" > conf/VERSION
}

src_install() {
	dodir /usr/share/gitolite/{conf,hooks} /usr/bin || die

	./src/gl-system-install "${D}"/usr/bin \
		"${D}"/usr/share/gitolite/conf "${D}"/usr/share/gitolite/hooks || die
	sed -i -e "s:${D}::g" "${D}/usr/bin/gl-setup" \
		"${D}/usr/share/gitolite/conf/example.gitolite.rc" || die

	rm "${D}/usr/bin/gitolite.pm"
	insinto "${VENDOR_LIB}"
	doins src/gitolite.pm || die

	dodoc README.mkd doc/*

	if use contrib; then
		insinto /usr/share/doc/${PF}
		doins -r contrib/ || die
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
