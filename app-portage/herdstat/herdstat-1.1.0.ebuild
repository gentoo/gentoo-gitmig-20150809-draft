# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/herdstat/herdstat-1.1.0.ebuild,v 1.1 2005/05/19 00:46:41 ka0ttic Exp $

inherit bash-completion toolchain-funcs

DESCRIPTION="A multi-purpose query tool capable of things such as displaying herd/developer information and displaying category/package metadata"
HOMEPAGE="http://developer.berlios.de/projects/herdstat/"
SRC_URI="http://download.berlios.de/herdstat/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~alpha ~hppa"
IUSE="debug doc unicode"

RDEPEND="net-misc/wget
	unicode? ( >=dev-cpp/libxmlpp-2.8.0-r1 )
	!unicode? ( >=dev-libs/xmlwrapp-0.5.0 )"
DEPEND=">=sys-apps/sed-4
	unicode? ( >=dev-cpp/libxmlpp-2.8.0-r1 )
	!unicode? ( >=dev-libs/xmlwrapp-0.5.0 )
	doc? ( dev-python/docutils )"

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_enable unicode) \
		|| die "econf failed"
	emake || die "emake failed"

	if use doc ; then
		cd doc ; make html || die "failed to build html"
	fi
}

src_install() {
	keepdir /var/lib/herdstat
	make DESTDIR="${D}" install || die "make install failed"
	dobashcompletion bashcomp
	dodoc AUTHORS ChangeLog README TODO NEWS doc/*.txt
	use doc && dohtml doc/*
}

pkg_postinst() {
	chown root:portage /var/lib/herdstat
	chmod 0775 /var/lib/herdstat

	einfo
	einfo "You must be in the portage group to use herdstat."
	einfo
	if use doc ; then
		einfo "See /usr/share/doc/${PF}/html/examples.html"
		einfo "for a sleu of examples"
	else
		einfo "See /usr/share/doc/${PF}/examples.txt.gz"
		einfo "for a sleu of examples"
	fi
	einfo
	if ! use unicode ; then
		einfo "NOTE: since you have not enabled unicode support via"
		einfo "USE=unicode, strings containing unicode characters will"
		einfo "be malformed.  Recompile with USE=unicode to avoid this."
	fi

	bash-completion_pkg_postinst
}
