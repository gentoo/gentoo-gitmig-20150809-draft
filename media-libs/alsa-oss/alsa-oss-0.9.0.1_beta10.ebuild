# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/alsa-oss/alsa-oss-0.9.0.1_beta10.ebuild,v 1.3 2002/07/11 06:30:38 drobbins Exp $

DESCRIPTION="Advanced Linux Sound Architecture OSS compatibility layer"
HOMEPAGE="http://www.alsa-project.org/"

DEPEND="virtual/glibc 
        ~media-libs/alsa-lib-0.9.0.1_beta10"

######################## Begin version munge #########################
# Below is the version hack from alsa-lib by Achim Gottinger <achim@gentoo.org>

#This alsa version appends a alphabetic character to the beta version.
#Portage doesn't seem to play well with this type of tarball versioning
#Rather than ignore this in the ebuild version, I have encoded the
#alphabetic beta suffix as an extra number suffix on the main version,
#i.e., alsa-oss-0.9.0beta10a --> alsa-oss-0.9.0.1_beta10
#If subsequent alsa-0.9.0beta's are released, this ebuild should be
#version independent, i.e alsa-lib-0.9.0beta10b --> alsa-lib-0.9.0.2_beta10
#just requires a copy of this ebuild to the new name. If alsa releases
#version 1.0, this silliness can end.
#This is probably overkill, but it was fun :)

#Transform P to match tarball version
#Grab the last revision number, 
#"bs" is short for "beta suffix", not what you're thinking :)
bs=${PV%_beta*} #wack off _beta*
t=${bs##*.} #wack off first three numbers, save this for later

#Transform to ASCII octal number of tarball beta revision suffix
let "a=141" #The octal number for ASCII lowercase "a"
let "bs=$t+$a-1"
bs=$( echo -e "\\$bs" ) #convert to character

MYPV="${PV/.${t}_beta/beta}${bs}"
MYP="${PN}-${MYPV}"

######################## End version Munge ##########################

S="${WORKDIR}/${MYP}"
SRC_URI="ftp://ftp.alsa-project.org/pub/oss-lib/${MYP}.tar.bz2"

src_compile() {                           
        ./configure \
                --host=${CHOST} \
                --prefix=/usr \
                || die "./configure failed"
        emake || die "Parallel Make Failed"
}

src_install() {
        make DESTDIR="${D}" install || die
}
