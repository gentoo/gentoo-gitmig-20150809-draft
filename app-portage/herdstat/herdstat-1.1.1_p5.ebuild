# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/herdstat/herdstat-1.1.1_p5.ebuild,v 1.1 2005/08/10 23:18:41 ka0ttic Exp $

inherit bash-completion toolchain-funcs

DESCRIPTION="A multi-purpose query tool capable of things such as displaying herd/developer information and displaying category/package metadata"
HOMEPAGE="http://developer.berlios.de/projects/herdstat/"
SRC_URI="http://download.berlios.de/herdstat/${P}.tar.bz2"
RESTRICT="primaryuri"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86"
IUSE="debug doc"

RDEPEND=">=dev-libs/xmlwrapp-0.5.0"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	dev-util/pkgconfig
	doc? ( dev-python/docutils )"
RDEPEND="${RDEPEND} net-misc/wget"

src_compile() {
	econf $(use_enable debug) || die "econf failed"
	emake || die "emake failed"

	if use doc ; then
		cd doc ; make html || die "failed to build html"
	fi
}

src_test() {
	cd tests
	make all check || die "make check failed"
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

	einfo
	einfo "You must be in the portage group to use herdstat."
	einfo
	if use doc ; then
		einfo "See /usr/share/doc/${PF}/html/examples.html"
	else
		einfo "See /usr/share/doc/${PF}/examples.txt.gz"
	fi
	einfo "for a sleu of examples on using herdstat."
	einfo
	einfo "As of 1.1.1_rc6, ${PN} supports configuration files."
	einfo "See /usr/share/doc/${PF}/herdstatrc.example.gz"
	einfo "for more information."
	einfo

	bash-completion_pkg_postinst
}
