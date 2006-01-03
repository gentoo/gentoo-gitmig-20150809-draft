# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/bogofilter/bogofilter-1.0.1.ebuild,v 1.1 2006/01/03 14:23:01 tove Exp $

DESCRIPTION="Bayesian spam filter designed with fast algorithms, and tuned for speed."
HOMEPAGE="http://bogofilter.sourceforge.net/"
SRC_URI="mirror://sourceforge/bogofilter/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
#KEYWORDS="${KEYWORDS} ~arm ~mips" # missing, see bug #74046
IUSE="doc gsl berkdb sqlite"

DEPEND="
	|| ( sys-libs/glibc dev-libs/libiconv )
	berkdb?  ( >=sys-libs/db-3.2 )
	!berkdb? (
		sqlite?  ( >=dev-db/sqlite-3.2.6 )
		!sqlite? ( >=sys-libs/db-3.2 ) )
	gsl? ( sci-libs/gsl )"
#	app-arch/pax" # only needed for bf_tar

src_compile() {
	local myconf=""
	myconf="$(use_with !gsl included-gsl)"

	# determine backend: berkdb *is* default
	if use berkdb && use sqlite ; then
		einfo "Both berkdb and sqlite are in USE."
		einfo "Choosing berkdb as default database backend."
	elif use sqlite ; then
		myconf="${myconf} --with-database=sqlite"
	elif ! use berkdb ; then
		einfo "Using berkdb as database backend."
	fi

	econf ${myconf} || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	exeinto /usr/share/${PN}/contrib
	doexe contrib/{bogofilter-qfe,parmtest,randomtrain}.sh \
		contrib/{bfproxy,bogominitrain,mime.get.rfc822,printmaildir}.pl \
		contrib/{spamitarium,stripsearch}.pl || die "doexec failed"

	insinto /usr/share/${PN}/contrib
	doins contrib/{README.*,dot-qmail-bogofilter-default} \
		contrib/{bogogrep.c,bogo.R,bogofilter-milter.pl,*.example} \
		contrib/{trainbogo,scramble}.sh || die "doins failed"

	dodoc AUTHORS NEWS README RELEASE.NOTES* TODO GETTING.STARTED \
		doc/integrating-with-* doc/README.{db,sqlite} || die "dodoc failed"

	dodir /usr/share/doc/${PF}/samples
	mv "${D}"/etc/* "${D}"/usr/share/doc/${PF}/samples/
	rmdir "${D}"/etc

	if use doc; then
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
