# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/esearch/esearch-0.7.1-r8.ebuild,v 1.2 2011/02/23 17:01:42 arfrever Exp $

EAPI=3
PYTHON_DEPEND=2:2.4
PYTHON_USE_WITH=readline

inherit base eutils multilib python

DESCRIPTION="Replacement for 'emerge --search' with search-index"
HOMEPAGE="http://david-peter.de/esearch.html"
SRC_URI="http://david-peter.de/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="linguas_it"

RDEPEND=">=sys-apps/portage-2.0.50"

PATCHES=( "${FILESDIR}"/97462-esearch-metadata.patch
	"${FILESDIR}"/97969-ignore-missing-ebuilds.patch
	"${FILESDIR}"/120817-unset-emergedefaultopts.patch
	"${FILESDIR}"/124601-remove-deprecated-syntax.patch
	"${FILESDIR}"/132548-multiple-overlay.patch
	"${FILESDIR}"/231223-fix-deprecated.patch
	"${FILESDIR}"/253216-fix-ebuild-option.patch
	"${FILESDIR}"/186994-esync-quiet.patch
	"${FILESDIR}"/146555-esearch-manifest2.patch )

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_compile() { :; }

src_install() {
	dodir /usr/bin/ /usr/sbin/ || die "dodir failed"

	exeinto /usr/$(get_libdir)/esearch
	doexe eupdatedb.py esearch.py esync.py common.py || die "doexe failed"

	dosym /usr/$(get_libdir)/esearch/esearch.py /usr/bin/esearch || die "dosym failed"
	dosym /usr/$(get_libdir)/esearch/eupdatedb.py /usr/sbin/eupdatedb || die "dosym failed"
	dosym /usr/$(get_libdir)/esearch/esync.py /usr/sbin/esync || die "dosym failed"

	doman en/{esearch,eupdatedb,esync}.1 || die "doman failed"
	dodoc ChangeLog "${FILESDIR}/eupdatedb.cron" || die "dodoc failed"

	if use linguas_it ; then
		insinto /usr/share/man/it/man1
		doins it/{esearch,eupdatedb,esync}.1 || die "doins failed"
	fi

	python_convert_shebangs -r 2 "${D}"
}

pkg_postinst() {
	python_mod_optimize /usr/$(get_libdir)/esearch
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/esearch
}
