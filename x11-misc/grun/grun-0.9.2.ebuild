# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/grun/grun-0.9.2.ebuild,v 1.27 2006/02/16 11:28:26 nelchael Exp $

inherit eutils

IUSE="nls"

DESCRIPTION="A GTK/X11 application launcher with nice features such as a history"

PATCH_LEVEL="14"
RESTRICT="nomirror"
SRC_URI="mirror://debian/pool/main/g/grun/${PN}_${PV}.orig.tar.gz
		mirror://debian/pool/main/g/grun/${PN}_${PV}-${PATCH_LEVEL}.diff.gz"
HOMEPAGE="http://packages.debian.org/unstable/x11/grun.html"
# Removed:
# HOMEPAGE="http://www.geocities.com/ResearchTriangle/Facility/1468/sg/grun.html"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ppc amd64"

# The dependencies following the gentoo policy as suggested by gbevin
DEPEND="=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*
	nls? ( sys-devel/gettext )
	sys-devel/gnuconfig
	sys-devel/automake"

src_unpack() {
	unpack ${A}
	epatch ${WORKDIR}/${PN}_${PV}-${PATCH_LEVEL}.diff
}

src_compile() {
	local myconf

	use nls && myconf="--enable-nls" || myconf="--disable-nls"

	if [ -z ${TERM} ] ; then
		TERM=xterm
	fi

	ebegin "Running automake"
		automake --add-missing &>/dev/null
	eend $?

	econf \
		--enable-testfile \
		--with-default-xterm=${TERM} \
		--enable-associations \
		${myconf} || die
	emake || die
}

src_install() {
	einstall || die

	dodoc ABOUT-NLS AUTHORS BUGS ChangeLog \
		LANGUAGES NEWS README TODO
}

pkg_postinst() {
	einfo "It is recommended to bind grun to a keychain. Fluxbox users can"
	einfo "do this by appending e.g. the following line to ~/.fluxbox/keys:"
	einfo
	einfo "Mod4 r :ExecCommand grun"
	einfo
	einfo "Then reconfigure Fluxbox (using the menu) and hit <WinKey>-<r>"
	einfo
	einfo "The default system-wide definition file for associating file"
	einfo "extensions with applications is /usr/share/grun/gassoc, the"
	einfo "default system-wide definition file for recognized console"
	einfo "applications is /usr/share/grun/consfile. They can be overridden"
	einfo "on a per user basis by ~/.gassoc and ~/.consfile respectively."
	einfo
	einfo "To change the default terminal application grun uses, adjust the"
	einfo "TERM environment variable accordingly and remerge grun, e.g."
	einfo
	einfo "export TERM=Eterm && emerge grun"
}
