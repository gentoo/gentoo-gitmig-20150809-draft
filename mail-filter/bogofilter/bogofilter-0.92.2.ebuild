# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/bogofilter/bogofilter-0.92.2.ebuild,v 1.1 2004/07/19 17:16:31 lostlogic Exp $

DESCRIPTION="Bayesian spam filter designed with fast algorithms, and tuned for speed."
HOMEPAGE="http://bogofilter.sourceforge.net/"
SRC_URI="mirror://sourceforge/bogofilter/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~ppc64"
IUSE="doc"

DEPEND="virtual/libc
	!ppc64? ( doc? ( app-text/xmlto ) )
	>=sys-libs/db-3.2"
RDEPEND="virtual/libc
	>=sys-libs/db-3.2"

src_install() {
	make DESTDIR=${D} install || die

	exeinto /usr/lib/${PN}/contrib
	doexe contrib/{bogofilter-qfe,bogogrep,mime.get.rfc822,parmtest.sh}
	doexe contrib/{randomtrain,scramble,*.pl}

	insinto /usr/lib/${PN}/contrib
	doins contrib/{README.*,bogo.R,bogogrep.c,dot-qmail-bogofilter-default}
	doins contrib/{trainbogo.sh,*.example}

	dodoc AUTHORS CHANGES* COPYING INSTALL METHODS NEWS README
	dodoc RELEASE.NOTES* TODO doc/{integrating-with-*,*.HOWTO}

	dodir /usr/share/doc/${PF}/samples
	mv ${D}/etc/* ${D}/usr/share/doc/${PF}/samples/
	rmdir ${D}/etc

	#if xmlto is installed, html docu is gernerated automatically
	#if xmlto is not installed, there is still a html faq
	if use doc; then
		dohtml doc/*.html
	else
		dohtml doc/bogofilter-faq.html doc/bogofilter-faq-fr.html
	fi
}

pkg_postinst() {
	einfo "The goal of the bogofilter 0.17 series was to clean out this excess code."
	einfo "A number of features have been removed."
	ewarn "Please read the RELEASE.NOTES-0.17 carefully!"
	einfo ""
	einfo "Contributed tools and documentation is in ${ROOT}usr/lib/${PN}/contrib"
	einfo "beside documentation in ${ROOT}usr/share/doc/${PF}."
}
