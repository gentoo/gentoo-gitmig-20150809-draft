# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/bogofilter/bogofilter-0.16.4.ebuild,v 1.1 2004/02/10 16:51:30 lostlogic Exp $

IUSE="doc"

DESCRIPTION="Bayesian spam filter designed with fast algorithms, and tuned for speed."
HOMEPAGE="http://bogofilter.sourceforge.net/"
SRC_URI="mirror://sourceforge/bogofilter/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~ia64 ~hppa ~amd64 ~mips ~ppc64 ~arm"

DEPEND="virtual/glibc
	!arm? ( !mips? ( !ppc64? ( doc? ( app-text/xmlto ) ) ) )
	>=sys-libs/db-3.2"

RDEPEND="virtual/glibc
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
	einfo "The goal of the bogofilter 0.16 series is to clean out this excess code."
	einfo "A number of features have been deprecated."
	ewarn "Please read the RELEASE.NOTES-0.16 carefully!"
	einfo ""
	einfo "Contributed tools and documentation is in ${ROOT}usr/lib/${PN}/contrib"
	einfo "beside documentation in ${ROOT}usr/share/doc/${PF}."
}
