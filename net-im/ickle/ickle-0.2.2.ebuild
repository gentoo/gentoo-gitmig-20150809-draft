# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Spider <spider.gentoo@darkmere.wanfear.com>
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.3 2002/02/04 15:46:51 gbevin Exp

S=${WORKDIR}/${P}

# Short one-line description of this package.
DESCRIPTION="ICQ 200x compatible ICQ client. limited featureset."

# Point to any required sources; these will be automatically
# downloaded by Portage.
SRC_URI="http://prdownloads.sourceforge.net/ickle/${P}.tar.gz"

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="http://ickle.sf.net"

DEPEND=">=x11-libs/gtk+-1.2.10
		>=x11-libs/gtkmm-1.2.5
		>=dev-libs/libsigc++-1.0.4
		>=sys-libs/lib-compat-1.0
		gnome? ( >= gnome-base/gnome-applets-1.4.0 
				 >= gnome-base/gnome-libs-1.4.1 )"

# Run-time dependencies, same as DEPEND if RDEPEND isn't defined:
#RDEPEND=""

src_compile() {
	local myflags
	myflags=""
	if [ -z "`use gnome`" ]
	then
		myflags="--without-gnome"
	else
		myflags="--with-gnome"
	fi
	./configure ${myflags} \
		--host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--localstatedir=/var/lib \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
	#make || die
}

src_install () {
	# You must *personally verify* that this trick doesn't install
	# anything outside of DESTDIR; do this by reading and
	# understanding the install part of the Makefiles. 
	make DESTDIR=${D} install || die

# For Makefiles that don't make proper use of DESTDIR, setting
	# prefix is often an alternative.  However if you do this, then
	# you also need to specify mandir and infodir, since they were
	# passed to ./configure as absolute paths (overriding the prefix
	# setting).
	#make \
	#	prefix=${D}/usr \
	#	mandir=${D}/usr/share/man \
	#	infodir=${D}/usr/share/info \
	#	install || die
	# Again, verify the Makefiles!  We don't want anything falling
	# outside of ${D}.
}
