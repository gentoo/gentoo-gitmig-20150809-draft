# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/grun/grun-0.9.2.ebuild,v 1.7 2002/08/14 23:44:15 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A GTK/X11 application launcher with nice features such as a history"

# Unfortunately the original homepage is not available anymore. The
# tarball and the patch (identiacal with grun_0.9.2-9.diff just
# renamed to grun-0.9.2-gentoo.diff) have been taken from
# http://packages.debian.org/unstable/x11/grun.html.

SRC_URI="http://ftp.us.debian.org/debian/pool/main/g/grun/grun_0.9.2.orig.tar.gz"
# Not valid anymore, see
# http://packages.debian.org/unstable/x11/grun.html instead
HOMEPAGE="http://www.geocities.com/ResearchTriangle/Facility/1468/sg/grun."
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

# The dependencies following the gentoo policy as suggested by gbevin
DEPEND="=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	patch -p0 <${FILESDIR}/${PF}-gentoo.diff || die
}

src_compile() {
	local myconf

	use nls && myconf="--enable-nls" || myconf="--disable-nls"

	if [ -z ${TERM} ] ; then
		TERM=xterm
	fi

	econf \
		--enable-testfile \
		--with-default-xterm=${TERM} \
		--enable-associations \
		${myconf} || die 
	emake || die
}

src_install() {
	make prefix=${D}/usr \
		localedir=${D}/usr/share/locale \
		mandir=${D}/usr/share/man \
		install || die 

	dodoc ABOUT-NLS AUTHORS BUGS COPYING ChangeLog INSTALL \
		LANGUAGES NEWS README TODO
}

pkg_postinst() {
	# The following hints will be printed in white
	MESSAGE_COLOR=37;
	echo -e "\033[1;${MESSAGE_COLOR}m";
	echo "####################################################################";
	echo "#                                                                  #";
	echo "# It is recommended to bind grun to a keychain. Fluxbox users can  #";
	echo "# do this by appending e.g. the following line to ~/.fluxbox/keys: #";
	echo "#                                                                  #";
	echo "# Mod4 r :ExecCommand grun                                         #";
	echo "#                                                                  #";
	echo "# Then reconfigure Fluxbox (using the menu) and hit <WinKey>-<r>   #";
	echo "#                                                                  #";
	echo "# The default system-wide definition file for associating file     #";
	echo "# extensions with applications is /usr/share/grun/gassoc, the      #";
	echo "# default system-wide definition file for recognized console       #";
	echo "# applications is /usr/share/grun/consfile. They can be overridden #";
	echo "# on a per user basis by ~/.gassoc and ~/.consfile respectively.   #";
	echo "#                                                                  #";
	echo "# To change the default terminal application grun uses, adjust the #";
	echo "# TERM environment variable accordingly and remerge grun, e.g.     #";
	echo "#                                                                  #";
	echo "# export TERM=Eterm && emerge grun                                 #";
	echo "#                                                                  #";
	echo "# Have fun!                                                        #";
	echo "#                                                                  #";
	echo "####################################################################";
	echo -e "\033[0m";
}
