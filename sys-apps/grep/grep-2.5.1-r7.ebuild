# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/grep/grep-2.5.1-r7.ebuild,v 1.4 2005/03/22 08:06:30 eradicator Exp $

inherit flag-o-matic eutils multilib

DESCRIPTION="GNU regular expression matcher"
HOMEPAGE="http://www.gnu.org/software/grep/grep.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz
	mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="build nls pcre static uclibc"

RDEPEND=""
DEPEND="${RDEPEND}
	pcre? (	dev-libs/libpcre )
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix a weird sparc32 compiler bug
	echo "" >> src/dfa.h

	epatch "${FILESDIR}"/${PV}-manpage.patch
	epatch "${FILESDIR}"/${PV}-manpage-line-buffering.patch
	epatch "${FILESDIR}"/${P}-fgrep.patch.bz2
	epatch "${FILESDIR}"/${P}-i18n.patch.bz2
	epatch "${FILESDIR}"/${P}-gofast.patch.bz2
	epatch "${FILESDIR}"/${P}-oi.patch.bz2
	epatch "${FILESDIR}"/${P}-restrict_arr.patch
	epatch "${FILESDIR}"/${PV}-utf8-case.patch
	# uclibc does not suffer from this glibc bug.
	use uclibc || epatch "${FILESDIR}"/${PV}-tests.patch
}

src_compile() {
	if use static ; then
		append-flags -static
		append-ldflags -static
	fi

	local myconf
	if use uclibc ; then
		myconf="${myconf} --without-included-regex"
	else
		myconf="${myconf} $(use_enable pcre perl-regexp)"
	fi
	econf \
		--bindir=/bin \
		$(use_enable nls) \
		${myconf} \
		|| die "econf failed"

	if use pcre && ! use uclibc ; then
		sed -i \
			-e "s:-lpcre:/usr/$(get_libdir)/libpcre.a:g" \
			{lib,src}/Makefile \
			|| die "sed Makefile failed"
	fi

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	# Override the default shell scripts... grep knows how to act
	# based on how it's called
	ln -sfn grep "${D}"/bin/egrep || die "ln egrep failed"
	ln -sfn grep "${D}"/bin/fgrep || die "ln fgrep failed"

	if use build ; then
		rm -r "${D}"/usr/share
	else
		dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	fi
}
