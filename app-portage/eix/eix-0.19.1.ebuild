# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/eix/eix-0.19.1.ebuild,v 1.1 2009/12/19 15:50:12 darkside Exp $

EAPI=2

inherit multilib

DESCRIPTION="Search and query ebuilds, portage incl. local settings, ext. overlays, version changes, and more"
HOMEPAGE="http://eix.sourceforge.net"
SRC_URI="mirror://sourceforge/eix/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~ia64-hpux ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x86-solaris"
IUSE="+bzip2 debug doc hardened nls optimization strong-optimization sqlite tools"

RDEPEND="sqlite? ( >=dev-db/sqlite-3 )
	nls? ( virtual/libintl )
	bzip2? ( app-arch/bzip2 )"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	doc? ( dev-python/docutils )
	nls? ( sys-devel/gettext )"

src_unpack() {
	local i s
	for i in ${A}
	do
		s="${DISTDIR%/}/${i}"
		einfo "Unpacking ${s} to ${PWD}"
		test -s "${s}" || die "${s} does not exist"
		xz -dc -- "${s}" | tar xof - || die "Unpacking ${s} failed"
	done
}

src_configure() {
	econf $(use_with bzip2) $(use_with sqlite) $(use_with doc rst) \
		$(use_enable nls) $(use_enable tools separate-tools) \
		$(use_enable hardened security) $(use_enable optimization) \
		$(use_enable strong-optimization) $(use_enable debug debugging) \
		--with-ebuild-sh-default="/usr/$(get_libdir)/portage/bin/ebuild.sh" \
		--with-portage-rootpath="${ROOTPATH}" \
		--with-eprefix-default="${EPREFIX}" \
		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
		--htmldir="${EPREFIX}/usr/share/doc/${PF}/html"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	prepalldocs
}
