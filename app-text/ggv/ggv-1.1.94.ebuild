# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/ggv/ggv-1.1.94.ebuild,v 1.5 2002/07/30 20:34:51 stroke Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gnome Ghostview"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"
SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86"

RDEPEND=">=gnome-base/gnome-libs-1.4.1.4
	bonobo? ( >=gnome-base/bonobo-1.0.19-r1 )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	local myconf=""

	use nls || myconf="--disable-nls"
	if use bonobo; then
		myconf="${myconf} --with-bonobo"
	else
		myconf="${myconf} --without-bonobo"
	fi

	./configure --build=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var/lib \
		--disable-install-schemas \
		${myconf} || die

	# CFLAGS was slurped up by ./configure above.  It's now in the
	# Makefiles.  We don't want to override it with our own.
	unset CFLAGS
	emake || die
}

src_install() {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/lib \
		install || die
	dodoc ABOUT-NLS AUTHORS ChangeLog COPYING COPYING-DOCS NEWS README TODO
}

pkg_postinst() {
    # This is from the devhelp ebuild...
    # Fix gconf permissions
    killall gconfd-1 2>/dev/null >/dev/null
    chmod o+rX /etc/gconf -R
    # Install schemas
    gconftool-1 --shutdown
    SOURCE=xml::/etc/gconf/gconf.xml.defaults
    GCONF_CONFIG_SOURCE=$SOURCE \
		gconftool-1 --makefile-install-rule \
		/etc/gconf/schemas/${PN}.schemas \
		# 2>/dev/null >/dev/null || exit 1
    assert "gconftool-1 execution failed"
}

