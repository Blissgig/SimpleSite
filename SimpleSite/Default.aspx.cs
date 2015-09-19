using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI.HtmlControls;

namespace SimpleSite
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string sUserAgent = Request.UserAgent.ToString().ToLower();
                string sIdent = Request.QueryString["ID"];
                SqlConnection cnArticles = new SqlConnection("Server=SERVER_NAME;Database=DB_NAME;User ID=USER_NAME;Password=PASSWORD;Trusted_Connection=False;");
                SqlCommand cmArticles = new SqlCommand();
                if (IsMobile(sUserAgent) == true)
                {
                    //If this is a mobile device, add the mobile css to adjust the layout.
                    HtmlLink cssLink = new HtmlLink();
                    cssLink.Attributes.Add("rel", "stylesheet");
                    cssLink.Attributes.Add("type", "text/css");
                    cssLink.Href = "CSS/Mobile.css";
                    this.Page.Header.Controls.Add(cssLink);
                }


                if (sIdent == null || sIdent.Trim().Length == 0)
                {
                    sIdent = "1"; //Default article
                }

                cmArticles.CommandText = "spGetArticle";
                cmArticles.CommandType = System.Data.CommandType.StoredProcedure;
                cmArticles.Parameters.Add("@iIdent", SqlDbType.Int).Value = Convert.ToInt16(sIdent);
                cmArticles.Connection = cnArticles;
                cnArticles.Open();

                SqlDataReader drArticles = cmArticles.ExecuteReader();
                drArticles.Read();

                if (drArticles.HasRows == true)
                {
                    //Title article
                    this.Title = drArticles.GetString(0).Trim() + " at Blissgig.com";

                    this.articleIcon.Src = "images/" + drArticles.GetString(3) + ".png";
                    this.articleTitle.InnerText = drArticles.GetString(0).Trim();
                    this.articleDate.InnerText = drArticles.GetDateTime(2).ToString("MMMM dd, yyyy");
                    this.articleBody.InnerHtml = drArticles.GetString(1).Trim();
                }

                //List of articles
                drArticles.NextResult();
                while (drArticles.Read())
                {
                    //Article Parent
                    HtmlGenericControl ArticleDiv = new HtmlGenericControl("div");
                    ArticleDiv.Attributes["class"] = "ArticleButton";
                    ArticleDiv.ID = "article" + drArticles.GetSqlInt32(0).ToString();

                     //Icon
                    Image imgIcon = new Image();
                    imgIcon.CssClass = "ButtonIcon";
                    imgIcon.ImageUrl = "images/" + drArticles.GetString(3) + ".png";
                    ArticleDiv.Controls.Add(imgIcon);

                    //Title
                    HtmlGenericControl ArticleTitle = new HtmlGenericControl("div");
                    ArticleTitle.Attributes["class"] = "ButtonTitle";
                    ArticleTitle.InnerHtml = "<a href=default.aspx?id=" + drArticles.GetSqlInt32(0).ToString() + ">" + drArticles.GetString(1) + "</a>";
                    ArticleDiv.Controls.Add(ArticleTitle);
                    this.articles.Controls.Add(ArticleDiv);
                }
            }
            catch (Exception ex)
            {
                LogException(ex);
            }
        }

        private bool IsMobile(string sUserAgent)
        {
            bool bReturn = false;

            try
            {
                if (sUserAgent != null)
                {
                    if (sUserAgent.Contains("iphone") ||
                        sUserAgent.Contains("blackberry") ||
                        sUserAgent.Contains("mobile") ||
                        sUserAgent.Contains("windows phone") ||
                        sUserAgent.Contains("windows ce") ||
                        sUserAgent.Contains("opera mini") ||
                        sUserAgent.Contains("palm"))
                    {
                        bReturn = true;
                    }
                }
            }
            catch (Exception ex)
            {
                LogException(ex);
            }

            return bReturn;
        }

        private void LogException(Exception ex)
        {
            Console.WriteLine(ex.Message);
        }
    }
}