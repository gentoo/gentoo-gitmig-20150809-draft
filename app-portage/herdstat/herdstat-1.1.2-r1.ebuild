# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/herdstat/herdstat-1.1.2-r1.ebuild,v 1.5 2008/05/06 03:34:58 drac Exp $

inherit bash-completion eutils

TEST_DATA_PV="20051023"
TEST_DATA_P="${PN}-test-data-${TEST_DATA_PV}"

DESCRIPTION="Query tool capable of displaying herd/developer information category/package metadata"
HOMEPAGE="http://developer.berlios.de/projects/herdstat/"
SRC_URI="http://download.berlios.de/${PN}/${P}.tar.bz2
	test? ( http://download.berlios.de/lib${PN}/${TEST_DATA_P}.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~ia64 ~mips ppc sparc x86"
IUSE="debug doc ncurses test"

RDEPEND="~dev-cpp/libherdstat-0.1.1"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	dev-util/pkgconfig
	doc? ( dev-python/docutils )"

src_unpack () {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-gcc43.patch \
		"${FILESDIR}"/${PV}-herds-xml-location.patch
}

src_compile() {
	econf \
		--with-test-data="${WORKDIR}"/${TEST_DATA_P} \
		$(use_enable debug) \
		$(use_with ncurses) \
		|| die "econf failed"

	emake || die "emake failed"

	if use doc ; then
		cd doc ; make html || die "failed to build html"
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dobashcompletion bashcomp
	dodoc AUTHORS ChangeLog README TODO NEWS doc/*.txt \
		doc/herdstatrc.example
	use doc && dohtml doc/*

	keepdir /var/lib/herdstat
	fperms 0775 /var/lib/herdstat
}

pkg_preinst() {
	chgrp portage "${D}"/var/lib/herdstat
}

pkg_postinst() {
	# remove any previous caches, as it's possible that the internal
	# format has changed, and may cause bugs.
	rm -f "${ROOT}"/var/lib/herdstat/*cache*

	elog
	elog "You must be in the portage group to use herdstat."
	elog
	if use doc ; then
		elog "See /usr/share/doc/${PF}/html/examples.html"
	else
		elog "See /usr/share/doc/${PF}/examples.txt.gz"
	fi
	elog "for a sleu of examples on using herdstat."
	elog
	elog "As of 1.1.1_rc6, ${PN} supports configuration files."
	elog "See /usr/share/doc/${PF}/herdstatrc.example.gz"
	elog "for more information."
	elog

	bash-completion_pkg_postinst
}
