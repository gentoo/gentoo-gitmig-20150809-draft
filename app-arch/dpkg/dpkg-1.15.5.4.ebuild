# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/dpkg/dpkg-1.15.5.4.ebuild,v 1.1 2009/12/08 01:29:22 jer Exp $

inherit eutils multilib autotools

DESCRIPTION="Package maintenance system for Debian"
HOMEPAGE="http://packages.qa.debian.org/dpkg"
SRC_URI="mirror://debian/pool/main/d/${PN}/${P/-/_}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~s390 ~sh ~sparc ~x86"
IUSE="bzip2 nls test unicode zlib"

LANGS="de es fr hu ja pl pt_BR ru sv"
for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

RDEPEND=">=dev-lang/perl-5.6.0
	dev-perl/TimeDate
	>=sys-libs/ncurses-5.2-r7
	zlib? ( >=sys-libs/zlib-1.1.4 )
	bzip2? ( app-arch/bzip2 )"
DEPEND="${RDEPEND}
	nls? ( app-text/po4a )
	test? ( dev-perl/Test-Pod dev-perl/IO-String )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.15.5-nls.patch
	epatch "${FILESDIR}"/${PN}-1.15.5-unicode.patch
	eautoreconf
}

src_compile() {
	econf \
		$(use_with bzip2 bz2) \
		$(use_enable nls) \
		$(use_enable unicode) \
		$(use_with zlib) \
		--without-selinux \
		--without-start-stop-daemon \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	strip-linguas ${LANGS}
	if [ -z "${LINGUAS}" ] ; then
		LINGUAS=none
	fi

	emake DESTDIR="${D}" LINGUAS="${LINGUAS}" install || die "emake install failed"
	rm "${D}"/usr/sbin/install-info || die "rm install-info failed"
	dodoc ChangeLog INSTALL THANKS TODO
	keepdir /usr/$(get_libdir)/db/methods/{mnt,floppy,disk}
	keepdir /usr/$(get_libdir)/db/{alternatives,info,methods,parts,updates}
}
