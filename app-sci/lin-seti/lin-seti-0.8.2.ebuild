# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/lin-seti/lin-seti-0.8.2.ebuild,v 1.2 2004/07/31 21:57:31 s4t4n Exp $

DESCRIPTION="A Seti@Home cache manager, cache-compatible with Seti Driver. Can be run as system daemon."
HOMEPAGE="http://lin-seti.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="x86 ~ppc ~sparc ~hppa"

DEPEND="app-sci/setiathome"

src_compile()
{
	# override lin-seti self-calculated cflags, force system wide install
	# otherwise a home directory installation would be attempted
	# if emerge doesn't run as root
	econf MY_CFLAGS="${CFLAGS}"         \
			--enable-system-install         \
			|| die "Configuration failed"
	emake || die "Compilation failed"
}

src_install()
{
	# copy documentation manually as make install doesn't do that
	dodoc AUTHORS COPYING ChangeLog INSTALL LEGGIMI NEWS README THANKS TODO

	einstall prefix=${D} || die "Installation failed"

	# Let's see if this file already exists: if so we will not install it
	if [ -a "/opt/setiathome/cache/1/user_info.sah" ] ; then
		rm ${D}/opt/setiathome/cache/1/user_info.sah
	fi
	# Otherwise the ebuild will overwrite this file!
	# And THAT is bad: if the client runs in daemon mode,
	# when switching to that dir it will wait forever for someone to give it
	# some info (which would be impossible, being detached from all terminals)!
}

pkg_postinst ()
{
	einfo "NOTICE 1: If you use SETI Driver for Windows"
	einfo "to share the cache make sure it is"
	einfo "version 1.6.4.0 or higher!"
	einfo
	einfo "NOTICE 2: If you decide to use the new"
	einfo "UID and GID features of lin-seti,"
	einfo "make sure to change the ownership of your cache path!"
}
