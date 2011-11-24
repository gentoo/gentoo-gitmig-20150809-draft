# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/esearch/esearch-0.7.2-r2.ebuild,v 1.3 2011/11/24 20:36:42 zmedico Exp $

EAPI=3
PYTHON_DEPEND=2:2.4
PYTHON_USE_WITH=readline

inherit base eutils multilib python

DESCRIPTION="Replacement for 'emerge --search' with search-index"
HOMEPAGE="http://david-peter.de/esearch.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2 http://dev.gentoo.org/~fuzzyray/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris"
IUSE="linguas_fr linguas_it"

RDEPEND="sys-apps/portage"

PATCHES=( "${FILESDIR}"/${PV}-esync-quiet.patch
	"${FILESDIR}"/${PV}-make-prefix-aware.patch
	"${FILESDIR}"/${PV}-update-shebang-lines.patch
)

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_compile() { :; }

src_install() {
	dodir /usr/bin/ /usr/sbin/ || die "dodir failed"

	exeinto /usr/$(get_libdir)/esearch
	doexe eupdatedb.py esearch.py esync.py common.py || die "doexe failed"

	dosym ../$(get_libdir)/esearch/esearch.py /usr/bin/esearch || die "dosym failed"
	dosym ../$(get_libdir)/esearch/eupdatedb.py /usr/sbin/eupdatedb || die "dosym failed"
	dosym ../$(get_libdir)/esearch/esync.py /usr/sbin/esync || die "dosym failed"

	doman en/{esearch,eupdatedb,esync}.1 || die "doman failed"
	dodoc ChangeLog "${FILESDIR}/eupdatedb.cron" || die "dodoc failed"

	if use linguas_it ; then
		insinto /usr/share/man/it/man1
		doins it/{esearch,eupdatedb,esync}.1 || die "doins failed"
	fi

	if use linguas_fr ; then
		insinto /usr/share/man/fr/man1
		doins fr/{esearch,eupdatedb,esync}.1 || die "doins failed"
	fi

	python_convert_shebangs -r 2 "${ED}"
}

pkg_postinst() {
	python_mod_optimize /usr/$(get_libdir)/esearch
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/esearch
}
