# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/adesklets/adesklets-0.6.1-r1.ebuild,v 1.11 2009/05/05 18:26:48 ssuominen Exp $

inherit eutils perl-module autotools

DESCRIPTION="An interactive Imlib2 console for the X Window system"
HOMEPAGE="http://adesklets.sf.net/"
SRC_URI="mirror://sourceforge/adesklets/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE="X python perl debug ctrlmenu fontconfig"

RDEPEND="X? (
		x11-libs/libX11
		x11-apps/xprop
		x11-libs/libXt
		python? ( >=dev-lang/python-2.4.3-r1 )
		perl? ( >=dev-lang/perl-5.8.2 )
		fontconfig? ( >=media-libs/fontconfig-2.3.2-r1 )
		>=x11-apps/xwininfo-1.0.2
	)
	>=media-libs/imlib2-1.2.0-r2
	>=sys-apps/sed-4.1.4-r1
	>=sys-apps/coreutils-5.94-r1
	>=sys-process/procps-3.2.6"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.20
	X? ( x11-proto/xproto )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	#Fix for bug #123538: control context menu fix
	epatch "${FILESDIR}"/${PN}-ctrlmenu.patch

	#Fix for bug #131813: linker flags ordering
	epatch "${FILESDIR}"/${P}-fix-as-needed.patch

	#Fix for bug #148988: fontconfig >= 2.4 support
	use fontconfig &&
	{
		if has_version ">=media-libs/fontconfig-2.4"; then
			epatch "${FILESDIR}"/${P}-fontconfig.patch
			eautoreconf
		fi
	}

	# when performing minor changes to src/adesklets.c or src/commands.c,
	# touching these files will avoid unneeded processing
	touch scripting/enums scripting/prototypes
}

src_compile() {
	local myconf=""

	use X || myconf="--without-x"
	use python || myconf="${myconf} --without-python-support"
	use perl || myconf="${myconf} --without-perl-support"
	myconf="${myconf} $(use_enable debug)"
	use ctrlmenu && myconf="--enable-control-on-context-menu"
	use fontconfig || myconf="${myconf} --without-fontconfig"

	econf ${myconf} || die
	emake || die
}

src_install() {
	#a bit of black magick to fix bug #157002
	use fontconfig &&
	{
		if has_version ">=media-libs/fontconfig-2.4"; then
			if [ "`cat doc/Makefile | grep \/bin\/sh\ \$\(SHELL\)`" != "" ]; then
				sed -i 's/\/bin\/sh//' doc/Makefile
			fi
		fi
	}

	dodir usr/share/info
	dodir usr/share/man/man1
	make DESTDIR="${D}" install || die
	doinfo doc/*.info || die "info page installation failed"
	doman doc/*.1 || die "man page installation failed"
	dodoc ChangeLog NEWS TODO AUTHORS
	use debug &&
	{
		echo 'ADESKLETS_LOG="~/adesklets_log"' > 70adesklets
		doenvd 70adesklets
	}

	# Fix for bug #142169
	use perl && fixlocalpod
}

pkg_postinst()
{
	use X ||
	{
		ewarn "You did not install the X Window support for ${P}"
		ewarn "If you intend to use it to display desklets, this"
		ewarn "is a mistake."
		echo
		ewarn "Type USE=\"X\" emerge adesklets to correct this."
		echo
		einfo "Please also note that if it is what you intended"
		einfo "to do, you need also to install imlib2 without"
		einfo "X support to effectively remove all dependencies."
		echo
	}

	use python ||
	{
		ewarn "You did not install the python bindings for ${P}"
		ewarn "If you intend to use it to display desklets, this"
		ewarn "is most probably an error."
		echo
		ewarn "Type USE=\"python\" emerge adesklets to correct this."
		echo
	}

	use debug &&
	{
		ewarn "You installed a debug build. Make sure you do:"
		echo
		ewarn "source /etc/profile"
		echo
		ewarn "If you want to use adesklets from your already"
		ewarn "opened sessions. The sessions log are automatically"
		ewarn "saved to /tmp/adesklets_log.pid*."
	}
}
