# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/fontconfig/fontconfig-2.2.1.ebuild,v 1.12 2003/12/17 05:00:15 brad_mssw Exp $

inherit eutils

S=${WORKDIR}/${P}
DESCRIPTION="A library for configuring and customizing font access."
HOMEPAGE="http://freedesktop.org/Software/fontconfig"
SRC_URI="http://pdx.freedesktop.org/software/fontconfig/releases/${P}.tar.gz"

IUSE=""
LICENSE="fontconfig"
SLOT="1.0"

# Note about keywords here:
# >=kde-base/kdebase-3.1.2 has a fix needed to work with fontconfig 2.2 and higher,
# so don't mark this ebuild stable on archs where kde 3.1.2 is only ~.
# this of course doesn't apply to archs where kde has no keywords at all :-)
# -- danarmak@gentoo.org
KEYWORDS="x86 alpha ppc sparc ~mips ~hppa ~arm ia64 ~amd64 ppc64"

DEPEND=">=sys-apps/sed-4
	>=media-libs/freetype-2.1.4
	>=dev-libs/expat-1.95.3
	>=sys-apps/ed-0.2"

MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}
	cd ${S}

	local PPREFIX="${FILESDIR}/patch/${PN}"

	# Some patches from Redhat
	epatch ${PPREFIX}-2.1-slighthint.patch
	# Add our local fontpaths (duh dont forget!)
	epatch ${PPREFIX}-2.2-local_fontdir-r1.patch
	# Blacklist some fonts that break fontconfig
	epatch ${PPREFIX}-2.2-blacklist.patch
	# Remove the subpixel test from local.conf (#12757)
	epatch ${PPREFIX}-2.2-remove_subpixel_test.patch

	# The date can be troublesome
	sed -i "s:\`date\`::" configure
}

src_compile() {

	[ "${ARCH}" == "alpha" -a "${CC}" == "ccc" ] && \
		die "Dont compile fontconfig with ccc, it doesnt work very well"

	# disable docs only disables docs generation (!)
	econf  --disable-docs \
		--with-docdir=${D}/usr/share/doc/${PF} \
		--x-includes=/usr/X11R6/include \
		--x-libraries=/usr/X11R6/lib \
		--with-default-fonts=/usr/X11R6/lib/X11/fonts/Type1 || die

	# this triggers sandbox, we do this ourselves
	sed -i "s:fc-cache/fc-cache -f -v:sleep 0:" Makefile

	emake || die

	# remove Luxi TTF fonts from the list, the Type1 are much better
	sed -i "s:<dir>/usr/X11R6/lib/X11/fonts/TTF</dir>::" fonts.conf
}

src_install() {
	einstall confdir=${D}/etc/fonts \
		datadir=${D}/usr/share \
		docdir=${D}/usr/share/doc/${P} || die

	insinto /etc/fonts
	doins ${S}/fonts.conf
	newins ${S}/fonts.conf fonts.conf.new

	cd ${S}

	mv fc-cache/fc-cache.man fc-cache/fc-cache.1
	mv fc-list/fc-list.man fc-list/fc-list.1
	mv src/fontconfig.man src/fontconfig.3
	for x in fc-cache/fc-cache.1 fc-list/fc-list.1 src/fontconfig.3
	do
		doman ${x}
	done

	dodoc AUTHORS COPYING ChangeLog NEWS README
}

pkg_postinst() {
	# Changes should be made to /etc/fonts/local.conf, and as we had
	# too much problems with broken fonts.conf, we force update it ...
	# <azarah@gentoo.org> (11 Dec 2002)
	ewarn "Please make fontconfig related changes to /etc/fonts/local.conf,"
	ewarn "and NOT to /etc/fonts/fonts.conf, as it will be replaced!"
	mv -f ${ROOT}/etc/fonts/fonts.conf.new ${ROOT}/etc/fonts/fonts.conf
	rm -f ${ROOT}/etc/fonts/._cfg????_fonts.conf

	if [ "${ROOT}" = "/" ]
	then
		echo
		einfo "Creating font cache..."
		HOME="/root" /usr/bin/fc-cache -f
	fi
}
