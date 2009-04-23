# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/bogofilter/bogofilter-1.2.0.ebuild,v 1.6 2009/04/23 09:33:19 armin76 Exp $

inherit db-use flag-o-matic

DESCRIPTION="Bayesian spam filter designed with fast algorithms, and tuned for speed."
HOMEPAGE="http://bogofilter.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="berkdb sqlite"

DEPEND="virtual/libiconv
	berkdb?  ( >=sys-libs/db-3.2 )
	!berkdb? (
		sqlite?  ( >=dev-db/sqlite-3.5.4 )
		!sqlite? ( >=sys-libs/db-3.2 ) )
	sci-libs/gsl"
#	app-arch/pax" # only needed for bf_tar

src_compile() {
	local myconf="" berkdb=true
	myconf="--without-included-gsl"

	# determine backend: berkdb *is* default
	if use berkdb && use sqlite ; then
		elog "Both useflags berkdb and sqlite are in USE:"
		elog "Using berkdb as database backend."
	elif use sqlite ; then
		myconf="${myconf} --with-database=sqlite"
		berkdb=false
	elif ! use berkdb ; then
		elog "Neither berkdb nor sqlite are in USE:"
		elog "Using berkdb as database backend."
	fi

	# Include the right berkdb headers for FreeBSD
	if ${berkdb} ; then
		append-flags "-I$(db_includedir)"
	fi

	econf ${myconf} || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	exeinto /usr/share/${PN}/contrib
	doexe contrib/{bogofilter-qfe,parmtest,randomtrain}.sh \
		contrib/{bfproxy,bogominitrain,mime.get.rfc822,printmaildir}.pl \
		contrib/{spamitarium,stripsearch}.pl || die "doexec failed"

	insinto /usr/share/${PN}/contrib
	doins contrib/{README.*,dot-qmail-bogofilter-default} \
		contrib/{bogogrep.c,bogo.R,bogofilter-milter.pl,*.example} \
		contrib/vm-bogofilter.el \
		contrib/{trainbogo,scramble}.sh || die "doins failed"

	dodoc AUTHORS NEWS README RELEASE.NOTES* TODO GETTING.STARTED \
		doc/integrating-with-* doc/README.{db,sqlite} || die "dodoc failed"

	dohtml doc/*.html

	dodir /usr/share/doc/${PF}/samples
	mv "${D}"/etc/bogofilter.cf.example "${D}"/usr/share/doc/${PF}/samples/
	rmdir "${D}"/etc
}

pkg_postinst() {
	echo
	elog "If you need \"${ROOT}usr/bin/bf_tar\" please install app-arch/pax."
	echo
}
