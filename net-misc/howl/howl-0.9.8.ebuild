# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/howl/howl-0.9.8.ebuild,v 1.17 2006/04/23 17:53:05 kumba Exp $

inherit eutils flag-o-matic

DESCRIPTION="cross-platform implementation of the Zeroconf networking standard"
HOMEPAGE="http://www.porchdogsoft.com/products/howl/"
SRC_URI="http://www.porchdogsoft.com/download/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm hppa ia64 mips ppc ~ppc-macos ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="virtual/libc"
# sys-devel/automake - needed if we remove the html docs from /usr/share

# sw_log is unprovided (Bug #87436)
RESTRICT="test"

src_unpack() {
	unpack ${A}

	cd ${S}
	# patch fixes #84030 (missing linux/types.h include)
	epatch ${FILESDIR}/${P}-types.patch
}

src_compile() {
	# If we wanted to remove the html docs in /usr/share/howl....
	#einfo "Removing html docs from build process...."
	#sed -e 's/ docs//' < Makefile.am > Makefile.am.new || die "sed failed"
	#mv Makefile.am.new Makefile.am || die "move failed"
	#aclocal || die "aclocal failed"
	#automake || die "automake failed"

	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"
	dodoc AUTHORS COPYING ChangeLog INSTALL README TODO
	dohtml -r docs/

	# Install conf files
	insinto /etc/conf.d
	newins ${FILESDIR}/nifd.conf.d nifd
	newins ${FILESDIR}/mDNSResponder.conf.d mDNSResponder

	# Install init scripts
	insinto /etc/init.d
	newins ${FILESDIR}/nifd.init.d nifd
	newins ${FILESDIR}/mDNSResponder.init.d mDNSResponder

	# Fix the perms on the init scripts
	fperms a+x /etc/init.d/nifd /etc/init.d/mDNSResponder

	# howl-0.9.8 introduces a change in library naming,
	# preserve old libraries to not break things
	preserve_old_lib /usr/$(get_libdir)/libhowl-[0-9].[0-9].[0-9].so.[0-9].[0-9].[0-9]
	preserve_old_lib /usr/$(get_libdir)/libmDNSResponder-[0-9].[0-9].[0-9].so.[0-9].[0-9].[0-9]
}

pkg_postinst() {
	# inform user about library changes
	preserve_old_lib_notify /usr/$(get_libdir)/libhowl-[0-9].[0-9].[0-9].so.[0-9].[0-9].[0-9]
	preserve_old_lib_notify /usr/$(get_libdir)/libmDNSResponder-[0-9].[0-9].[0-9].so.[0-9].[0-9].[0-9]
}
