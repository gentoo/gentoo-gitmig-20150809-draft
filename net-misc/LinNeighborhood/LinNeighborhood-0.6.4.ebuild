# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Joao Schim <joao@schim.net>
# $HEADER $ 

S=${WORKDIR}/${P}
DESCRIPTION="LinNeighborhood is a easy to use frontend to samba/NETBios."
SRC_URI="http://www.bnro.de/~schmidjo/download/${P}.tar.gz"
HOMEPAGE="http://www.bnro.de/~schmidjo/index.html"

DEPEND="	>=x11-libs/gtk+-1.2 net-fs/samba
		nls? ( sys-devel/gettext ) "

RDEPEND="${DEPEND}"

src_compile() {

	local mylibs myopts

	use nls || myopts="--disable-nls"

	if [ "`use python`" ]
	then
		mylibs=`/usr/bin/python-config`

		cp configure configure.orig
		sed -e 's:PY_LIBS=".*":PY_LIBS="'"$mylibs"'":' configure.orig > configure || die
	fi
	
	./configure --prefix=/usr \
		--host=${CHOST} \
		--enable-ipv6 \
		${myopts} || die
	
	emake || die
}

src_install() {

	make prefix=${D}/usr install || die

	dodoc README AUTHORS TODO THANKS BUGS NEW COPYING ChangeLog
}
