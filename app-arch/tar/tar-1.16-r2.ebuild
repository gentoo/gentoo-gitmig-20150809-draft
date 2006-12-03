# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/tar/tar-1.16-r2.ebuild,v 1.4 2006/12/03 19:26:08 weeve Exp $

inherit flag-o-matic eutils

DESCRIPTION="Use this to make tarballs :)"
HOMEPAGE="http://www.gnu.org/software/tar/"
SRC_URI="http://ftp.gnu.org/gnu/tar/${P}.tar.bz2
	ftp://alpha.gnu.org/gnu/tar/${P}.tar.bz2
	mirror://gnu/tar/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ppc ~ppc-macos ~ppc64 ~s390 ~sh sparc x86 ~x86-fbsd"
IUSE="nls static"

RDEPEND=""
DEPEND="${RDEPEND}
	nls? ( >=sys-devel/gettext-0.10.35 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-segv.patch
	epatch "${FILESDIR}"/${P}-remove-GNUTYPE_NAMES.patch #155901

	if ! use userland_GNU ; then
		sed -i \
			-e 's:/backup\.sh:/gbackup.sh:' \
			scripts/{backup,dump-remind,restore}.in \
			|| die "sed non-GNU"
	fi
}

src_compile() {
	local myconf
	use static && append-ldflags -static
	use userland_GNU || myconf="--program-prefix=g"
	# Work around bug in sandbox #67051
	gl_cv_func_chown_follows_symlink=yes \
	econf \
		--enable-backup-scripts \
		--bindir=/bin \
		--libexecdir=/usr/sbin \
		$(use_enable nls) \
		${myconf} || die
	emake || die "emake failed"
}

src_install() {
	local p=""
	use userland_GNU || p=g

	emake DESTDIR="${D}" install || die "make install failed"

	# a nasty yet required symlink
	dodir /etc
	dosym /usr/sbin/${p}rmt /etc/${p}rmt

	dodoc AUTHORS ChangeLog* NEWS README* PORTS THANKS
	newman "${FILESDIR}"/tar.1 ${p}tar.1
	mv "${D}"/usr/sbin/${p}backup{,-tar}
	mv "${D}"/usr/sbin/${p}restore{,-tar}

	rm -f "${D}"/usr/$(get_libdir)/charset.alias
}
