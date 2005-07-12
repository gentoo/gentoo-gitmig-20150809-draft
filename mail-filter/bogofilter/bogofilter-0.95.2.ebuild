# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/bogofilter/bogofilter-0.95.2.ebuild,v 1.1 2005/07/12 09:11:37 tove Exp $

inherit eutils

DESCRIPTION="Bayesian spam filter designed with fast algorithms, and tuned for speed."
HOMEPAGE="http://bogofilter.sourceforge.net/"
SRC_URI="mirror://sourceforge/bogofilter/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
#KEYWORDS="${KEYWORDS} ~arm ~mips" # missing, see bug #74046
IUSE="doc gsl berkdb sqlite"

DEPEND="
	|| (
		sys-libs/glibc
		dev-libs/libiconv
	)
	berkdb?  ( >=sys-libs/db-3.2 )
	!berkdb? (
		sqlite?  ( >=dev-db/sqlite-3.2.2 )
		!sqlite? ( >=sys-libs/db-3.2 )
	)
	gsl? ( sci-libs/gsl )"
#	app-arch/pax" # only needed for bf_tar

pkg_setup() {
	einfo ""
	einfo "It is best to dump or backup your wordlists BEFORE upgrading!"
	einfo ""
	epause 3
}

src_compile() {
	local myconf=""
	useq !gsl && myconf="${myconf} --with-included-gsl" # 'without-' doesn't work
#	myconf="$(use_with !gsl included-gsl)"

	# determine backend: berkdb *is* default
	if useq berkdb && useq sqlite ; then
		einfo "Both berkdb and sqlite are in USE."
		einfo "Choosing berkdb as default database backend."
	elif useq sqlite ; then
		myconf="${myconf} --with-database=sqlite"
	elif ! useq berkdb ; then
		einfo "Using berkdb as database backend."
	fi

	econf ${myconf} || die "could not configure"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die

	exeinto /usr/share/${PN}/contrib
	doexe contrib/{bogofilter-qfe,bogogrep,mime.get.rfc822,parmtest.sh}
	doexe contrib/{randomtrain,scramble,*.pl}

	insinto /usr/share/${PN}/contrib
	doins contrib/{README.*,bogo.R,bogogrep.c,dot-qmail-bogofilter-default}
	doins contrib/{trainbogo.sh,*.example}

	dodoc AUTHORS COPYING INSTALL NEWS README
	dodoc RELEASE.NOTES* TODO doc/integrating-with-*
	dodoc GETTING.STARTED doc/README.{db,sqlite}

	dodir /usr/share/doc/${PF}/samples
	mv ${D}/etc/* ${D}/usr/share/doc/${PF}/samples/
	rmdir ${D}/etc

	if useq doc; then
		dohtml doc/*.html
	else
		dohtml doc/bogofilter-faq{,-fr}.html doc/bogofilter-tuning.HOWTO.html
	fi
}

pkg_postinst() {
	ewarn ""
	ewarn "Incompatible changes in bogofilter-0.93 and -0.94:"
	ewarn "Please read the documentation (RELEASE.NOTES)!"
	ewarn ""
	einfo ""
	einfo "If you need ${ROOT}usr/bin/bf_tar please install app-arch/pax."
	einfo ""
}
