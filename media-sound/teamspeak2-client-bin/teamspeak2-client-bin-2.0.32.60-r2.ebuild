# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/teamspeak2-client-bin/teamspeak2-client-bin-2.0.32.60-r2.ebuild,v 1.1 2004/03/04 00:34:55 eradicator Exp $

DESCRIPTION="The TeamSpeak voice communication tool"
HOMEPAGE="http://www.teamspeak.org"
LICENSE="as-is"
KEYWORDS="~x86"

IUSE="kde"
SLOT="0"
MY_P="`echo ${P} | sed -e 's/teamspeak\([0-9]\)-client-bin-\([0-9]\)\.\([0-9]\)\.\([0-9]\)\([0-9]\)\.\([0-9]\)\([0-9]\)/ts\1_client_rc2_\2\3\4\5/'`"
SRC_URI="ftp://teamspeak.krawall.de/releases/${MY_P}.tar.bz2"

DEPEND="virtual/x11
	virtual/glibc
	kde? ( >=kde-base/kdelibs-3.1.0 )
	media-gfx/imagemagick"
	# Note: ts2 client comes with its own speex library, so no need to
	# depend on it

S="${WORKDIR}/${MY_P}/setup.data/image"

src_install() {

	local dir="/opt/teamspeak2-client"
	dodir ${dir}

	# Edit the Teamspeak startscript to match our install directory
	sed -i -e "s:%installdir%:${dir}:g" TeamSpeak

	if [ `use kde` ] ; then
		# Install a teamspeak.protocol file for kde/konqueror to accept
		# teamspeak:// links
		insinto $(kde-config --prefix)/share/services/
		doins ${FILESDIR}/teamspeak.protocol
	fi

	# The next three are removed after the operation so that they are not
	# copied into the install directory
	dobin TeamSpeak && rm TeamSpeak
	newdoc Readme.txt README && rm Readme.txt
	dohtml -r manual/* && rm -rf manual

	# A symlink is created so that Help -> Read Manual still works
	dosym /usr/share/doc/${PF}/html ${dir}/manual
	
	# All regular files except the executables are made non executable
	find -type f -not \( -name "TeamSpeak.bin" -or -name "*.so*" -or \
		-name "tsControl" \) -exec chmod -x {} \;

	#Install the teamspeak icon.
	dodir /usr/share/pixmaps
	convert ${S}/icon.xpm ${S}/teamspeak.png
	cp ${S}/teamspeak.png ${D}/usr/share/pixmaps/
		
	cp -r * ${D}/${dir}
}

pkg_postinst() {

	echo
	einfo "Note: If you just upgraded from a version less than 2.0.32.60-r1,"
	einfo "your users' config files will incorrectly point to non-existant"
	einfo "soundfiles because they've been moved from their old location."
	einfo "You may want to perform the following commands:"
	einfo "# mkdir /usr/share/teamspeak2-client"
	einfo "# ln -s ${dir}/sounds /usr/share/teamspeak2-client/sounds"
	einfo "This way, each user won't have to modify their config files to"
	einfo "reflect this move."
	echo
}

