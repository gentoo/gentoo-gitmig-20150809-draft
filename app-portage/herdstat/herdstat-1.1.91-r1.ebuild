# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/herdstat/herdstat-1.1.91-r1.ebuild,v 1.1 2007/02/12 05:01:25 compnerd Exp $

inherit bash-completion eutils

TEST_DATA_PV="20060119"
TEST_DATA_P="${PN}-test-data-${TEST_DATA_PV}"

DESCRIPTION="A multi-purpose query tool capable of things such as displaying herd/developer information and displaying category/package metadata"
HOMEPAGE="http://developer.berlios.de/projects/herdstat/"
SRC_URI="http://download.berlios.de/${PN}/${P}.tar.bz2
	test? ( http://download.berlios.de/lib${PN}/${TEST_DATA_P}.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ppc ~s390 ~sh ~sparc ~x86"
IUSE="debug doc readline test"

RDEPEND=">=dev-cpp/libherdstat-0.2.0
		 readline? ( sys-libs/readline )"
DEPEND="${RDEPEND}
		>=sys-apps/sed-4
		dev-util/pkgconfig
		doc? ( dev-python/docutils )"

pkg_setup() {
	if has test $FEATURES && ! use test ; then
		die "FEATURES=test is set but USE=test is not; tests will fail without USE=test"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	if ! use readline ; then
		epatch ${FILESDIR}/${PN}-1.1.91-undefined-lhp.patch
	fi

	epatch ${FILESDIR}/herds-xml-location-update.patch
}

src_compile() {
	econf \
		--with-test-data=${WORKDIR}/${TEST_DATA_P} \
		--without-gtk \
		--without-qt \
		$(use_enable debug) \
		$(use_with readline) \
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
	chgrp portage ${IMAGE}/var/lib/herdstat
}

pkg_postinst() {
	# remove any previous caches, as it's possible that the internal
	# format has changed, and may cause bugs.
	rm -f ${ROOT}/var/lib/herdstat/*cache*

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
	elog "As of 1.1.1, ${PN} supports configuration files."
	elog "See /usr/share/doc/${PF}/herdstatrc.example.gz"
	elog "for more information."
	elog

	if use readline ; then
		elog "For information on using the new readline front-end,"
		if use doc ; then
			elog "see /usr/share/doc/${PF}/html/readline.html"
		else
			elog "see /usr/share/doc/${PF}/readline.txt.gz."
		fi
		elog
	fi

	bash-completion_pkg_postinst
}
