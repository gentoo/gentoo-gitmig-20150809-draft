inherit cvs

DESCRIPTION="A mastering application for jack"
HOMEPAGE="http://jamin.sourceforge.net/"

ECVS_SERVER="cvs.jamin.sourceforge.net:/cvsroot/jamin"
ECVS_MODULE="jam"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/jamin/"


SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~x86 ~ppc"
DEBUG="yes"
DEPEND="$DEPEND
        dev-libs/glib
        >=media-libs/libsndfile-1.0.0
        >=media-plugins/swh-plugins-0.4.2
        >=media-sound/jack-cvs-0.7.0
		>=sys-devel/autoconf-2.5"

#S="${WORKDIR}/${P}"
S="${WORKDIR}/jam"
src_compile() {
		cd ${S}
        export WANT_AUTOCONF_2_5=1
        sh autogen.sh
        econf ${myconf}|| die "configure failed"
        emake || die "parallel make failed"
}

src_install() {

         einstall || die "make install failed"


         pushd ${WORKDIR}
                cd pixmaps
                dodir /usr/share/jamin/pixmaps
                cp * ${D}/usr/share/jamin/pixmaps
        popd

}


pkg_postinst() {
        einfo "********************************************"
        einfo "edit your .jamrc"
        einfo "pixmaps are in /usr/share/jamin/pixmaps"
        einfo "********************************************"
}

